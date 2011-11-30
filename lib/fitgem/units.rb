module Fitgem
  # Enumeration of valid unit systems that can be sent to fitbit
  #
  # Set the {Fitgem::Client#api_unit_system} property to one of
  # these values to set the unit system used for all subsequent
  # API calls.
  #
  # See {https://wiki.fitbit.com/display/API/API-Unit-System} for
  # more information on how the various unit systems are used.
  class ApiUnitSystem
    # US Units
    #
    # Used by default in fitgem
    #
    # @return [String]
    def self.US
      "en_US"
    end

    # UK Units
    #
    # @return [String]
    def self.UK
      "en_GB"
    end

    # Metric Units
    #
    # @return [String]
    def self.METRIC
      ""
    end
  end

  # Enumeration of available distance units that may be used when
  # logging measurements or activities that involve distance.
  #
  # See {https://wiki.fitbit.com/display/API/API-Distance-Unit} for
  # more information about using distance units.
  class ApiDistanceUnit
    # @return [String]
    def self.centimeters
      "Centimeter"
    end

    # @return [String]
    def self.feet
      "Foot"
    end

    # @return [String]
    def self.inches
      "Inch"
    end

    # @return [String]
    def self.kilometers
      "Kilometer"
    end

    # @return [String]
    def self.meters
      "Meter"
    end

    # @return [String]
    def self.miles
      "Mile"
    end

    # @return [String]
    def self.millimeters
      "Millimeter"
    end

    # Steps are only valid distance units when logging walking or
    # running activities.  The distance is computed from the stride
    # length the user provides.
    #
    # @return [String]
    def self.steps
      "Steps"
    end

    # @return [String]
    def self.yards
      "Yards"
    end
  end
end
