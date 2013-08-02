module Fitgem
  class Client
    # Format any of a variety of date types into the formatted string
    # required when using the fitbit API.
    #
    # The date parameter can take several different kind of objects: a
    # DateTime object, a Date object, a Time object or a String object.  Furthermore,
    # the string object may be either the date in a preformatted string
    # ("yyyy-MM-dd"), or it may be the string values "today" or
    # "tomorrow".
    #
    # @param [DateTime, Date, Time, String] date The object to format into a
    #   date string
    # @raise [Fitgem::InvalidDateArgument] Raised when the object is
    #   not a DateTime, Date, Time or a valid (yyyy-MM-dd) String object
    # @return [String] Date in "yyyy-MM-dd" string format
    def format_date(date)
      if date.is_a? String
        case date
          when 'today'
            return Date.today.strftime("%Y-%m-%d")
          when 'yesterday'
            return (Date.today-1).strftime("%Y-%m-%d")
          else
            unless date =~ /\d{4}\-\d{2}\-\d{2}/
              raise Fitgem::InvalidDateArgument, "Invalid date (#{date}), must be in yyyy-MM-dd format"
            end
            return date
        end
      elsif Date === date || Time === date || DateTime === date
        return date.strftime("%Y-%m-%d")
      else
        raise Fitgem::InvalidDateArgument, "Date used must be a date/time object or a string in the format YYYY-MM-DD; supplied argument is a #{date.class}"
      end
    end

    # Format any of a variety of time-related types into the formatted string
    # required when using the fitbit API.
    #
    # The time parameter can take several different kind of objects: a DateTime object,
    # a Time object, or a String Object.  Furthermore, the string object may be either
    # the date in a preformatted string ("HH:mm"), or it may be the string value "now" to
    # indicate that the time value used is the current localtime.
    #
    # @param [DateTime, Time, String] time The object to format into a time string
    # @param [Hash] opts format time options
    # @option opts [TrueClass, FalseClass] :include_timezone Include timezone in the output or not
    # @raise [Fitgem::InvalidTimeArgument] Raised when the parameter object is not a
    #   DateTime, Time, or a valid ("HH:mm" or "now") string object
    # @return [String] Date in "HH:mm" string format
    def format_time(time, opts = {})
      format = opts[:include_timezone] ? "%H:%M%:z" : "%H:%M"
      if time.is_a? String
        case time
          when 'now'
            return DateTime.now.strftime format
          else
            unless time =~ /^\d{2}\:\d{2}$/
              raise Fitgem::InvalidTimeArgument, "Invalid time (#{time}), must be in HH:mm format"
            end
            timezone = DateTime.now.strftime("%:z")
            return opts[:include_timezone] ? [ time, timezone ].join : time
        end
      elsif DateTime === time || Time === time
        return time.strftime format
      else
        raise Fitgem::InvalidTimeArgument, "Date used must be a valid time object or a string in the format HH:mm; supplied argument is a #{time.class}"
      end
    end

    # Fetch the correct label for the desired measurement unit.
    #
    # The general use case for this method is that you are using the client for
    # a specific user, and wish to get the correct labels for the unit measurements
    # returned for that user.
    #
    # A secondary use case is that you wish to get the label for a measurement given a unit
    # system that you supply (by setting the Fitgem::Client.api_unit_system attribute).
    #
    # In order for this method to get the correct value for the current user's preferences,
    # the client must have the ability to make API calls.  If you respect_user_unit_preferences
    # is passed as 'true' (or left as the default value) and the client cannot make API calls
    # then an error will be raised by the method.
    #
    # @param [Symbol] measurement_type The measurement type to fetch the label for
    # @param [Boolean] respect_user_unit_preferences Should the method fetch the current user's
    #   specific measurement preferences and use those (true), or use the value set on Fitgem::Client.api_unit_system (false)
    # @raise [Fitgem::ConnectionRequiredError] Raised when respect_user_unit_preferences is true but the
    #   client is not capable of making API calls.
    # @raise [Fitgem::InvalidUnitSystem] Raised when the current value of Fitgem::Client.api_unit_system
    #   is not one of [ApiUnitSystem.US, ApiUnitSystem.UK, ApiUnitSystem.METRIC]
    # @raise [Fitgem::InvalidMeasurementType] Raised when the supplied measurement_type is not one of
    #   [:duration, :distance, :elevation, :height, :weight, :measurements, :liquids, :blood_glucose]
    # @return [String] The string label corresponding to the measurement type and
    #   current api_unit_system.
    def label_for_measurement(measurement_type, respect_user_unit_preferences=true)
      unless [:duration, :distance, :elevation, :height, :weight, :measurements, :liquids, :blood_glucose].include?(measurement_type)
        raise InvalidMeasurementType, "Supplied measurement_type parameter must be one of [:duration, :distance, :elevation, :height, :weight, :measurements, :liquids, :blood_glucose], current value is :#{measurement_type}"
      end

      selected_unit_system = api_unit_system

      if respect_user_unit_preferences
        unless connected?
          raise ConnectionRequiredError, "No connection to Fitbit API; one is required when passing respect_user_unit_preferences=true"
        end
        # Cache the unit systems for the current user
        @unit_systems ||= self.user_info['user'].select {|key, value| key =~ /Unit$/ }

        case measurement_type
          when :distance
            selected_unit_system = @unit_systems["distanceUnit"]
          when :height
            selected_unit_system = @unit_systems["heightUnit"]
          when :liquids
            selected_unit_system = @unit_systems["waterUnit"]
          when :weight
            selected_unit_system = @unit_systems["weightUnit"]
          when :blood_glucose
            selected_unit_system = @unit_systems["glucoseUnit"]
          else
            selected_unit_system = api_unit_system
        end
      end

      # Fix the METRIC system difference
      selected_unit_system = Fitgem::ApiUnitSystem.METRIC if selected_unit_system == "METRIC"

      # Ensure the target unit system is one that we know about
      unless [ApiUnitSystem.US, ApiUnitSystem.UK, ApiUnitSystem.METRIC].include?(selected_unit_system)
        raise InvalidUnitSystem, "The select unit system must be one of [ApiUnitSystem.US, ApiUnitSystem.UK, ApiUnitSystem.METRIC], current value is #{selected_unit_system}"
      end

      unit_mappings[selected_unit_system][measurement_type]
    end

    # Recursively turns arrays and hashes into symbol-key based
    # structures.
    #
    # @param [Array, Hash] The structure to symbolize keys for
    # @return A new structure with the keys symbolized
    def self.symbolize_keys(obj)
      case obj
      when Array
        obj.inject([]){|res, val|
          res << case val
          when Hash, Array
            symbolize_keys(val)
          else
            val
          end
          res
        }
      when Hash
        obj.inject({}){|res, (key, val)|
          nkey = case key
          when String
            key.to_sym
          else
            key
          end
          nval = case val
          when Hash, Array
            symbolize_keys(val)
          else
            val
          end
          res[nkey] = nval
          res
        }
      else
        obj
      end
    end

    protected

    # Defined mappings for unit measurements to labels
    def unit_mappings
      {
        ApiUnitSystem.US => { :duration => "milliseconds", :distance => "miles", :elevation => "feet", :height => "inches", :weight => "pounds", :measurements => "inches", :liquids => "fl oz", :blood_glucose => "mg/dL" },
        ApiUnitSystem.UK => { :duration => "milliseconds", :distance => "kilometers", :elevation => "meters", :height => "centimeters", :weight => "stone", :measurements => "centimeters", :liquids => "mL", :blood_glucose => "mmol/l" },
        ApiUnitSystem.METRIC => { :duration => "milliseconds", :distance => "kilometers", :elevation => "meters", :height => "centimeters", :weight => "kilograms", :measurements => "centimeters", :liquids => "mL", :blood_glucose => "mmol/l" }
      }
    end

  end
end
