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
end
