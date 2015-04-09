module Fitgem
  class InvalidArgumentError < ArgumentError
  end

  class UserIdError < Exception
  end

  class InvalidDateArgument < InvalidArgumentError
  end

  class InvalidTimeArgument < InvalidArgumentError
  end

  class InvalidTimeRange < InvalidArgumentError
  end

  class InvalidUnitSystem < InvalidArgumentError
  end

  class InvalidMeasurementType < InvalidArgumentError
  end

  class ConnectionRequiredError < Exception
  end

  class DeprecatedApiError < Exception
  end

  class ServiceUnavailableError < Exception
  end
end
