module Fitgem
  # Enumeration of valid locales that can be sent to fitbit
  #
  # Set the {Fitgem::Client#api_locale} property to one of
  # these values to set the locale used for all subsequent
  # API calls.
  #
  # See {https://wiki.fitbit.com/display/API/API+Localization} for
  # more information on how the various locales are used.
  class ApiLocale
    # US Locale
    #
    # Used by default in fitgem
    #
    # @return [String]
    def self.US
      "en_US"
    end

    # Australia Locale
    #
    # @return [String]
    def self.AU
      "en_AU"
    end

    # France Locale
    #
    # @return [String]
    def self.FR
      "fr_FR"
    end

    # Germany Locale
    #
    # @return [String]
    def self.DE
      "de_DE"
    end

    # Japan Locale
    #
    # @return [String]
    def self.JP
      "ja_JP"
    end

    # New Zealand Locale
    #
    # @return [String]
    def self.NZ
      "en_NZ"
    end

    # Spain Locale
    #
    # @return [String]
    def self.ES
      "es_ES"
    end

    # UK Locale
    #
    # @return [String]
    def self.UK
      "en_GB"
    end
  end
end
