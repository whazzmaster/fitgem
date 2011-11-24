module Fitgem
  # Enumeration of food form types
  #
  # Primarily used in calls to {#create_food}.
  class FoodFormType
    # Food in liquid form
    # @return [String]
    def self.LIQUID
      "LIQUID"
    end

    # Food in dry form
    # @return [String]
    def self.DRY
      "DRY"
    end
  end
end
