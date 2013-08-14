module Fitgem
  class Client
    # ==========================================
    #          Food Retrieval Methods
    # ==========================================

    # Get all foods logged on the supplied date
    #
    # @param [DateTime, Date, String] date
    # @return [Array] A list of the foods, each of which is a
    #   Hash containing the food details
    def foods_on_date(date)
      get("/user/#{@user_id}/foods/log/date/#{format_date(date)}.json")
    end

    # Get a list of the recently logged foods
    #
    # @return [Array] A list of foods, each of which is a Hash
    #   containing the food details
    def recent_foods
      get("/user/#{@user_id}/foods/log/recent.json")
    end

    # Get a list of the frequently logged foods
    #
    # @return [Array] A list of foods, each of which is a Hash
    #   containing the food details
    def frequent_foods
      get("/user/#{@user_id}/foods/log/frequent.json")
    end

    # Get a list of the favorite logged foods
    #
    # @return [Array] A list of foods, each of which is a Hash
    #   containing the food details
    def favorite_foods
      get("/user/#{@user_id}/foods/log/favorite.json")
    end

    # Get a list of all of the available food units
    #
    # @return [Array] List of food units
    def foods_units
      get('/foods/units.json')
    end

    # Get a hash containing the user's meal informarion
    #
    # @return [Hash] Meal information
    #
    # @since v0.9.0
    def meals
      get("/user/#{@user_id}/meals.json")
    end

    # ==========================================
    #           Food Query Methods
    # ==========================================

    # Search the foods database
    #
    # @param [String] query The query parameters for the food search
    # @return [Array] A list of foods, each of which is a Hash
    #   containing detailed food information
    def find_food(query)
      get("/foods/search.json?query=#{URI.escape(query)}")
    end

    # Get detailed information for a food
    #
    # @param [Integer, String] food_id
    # @return [Hash] Hash containing detailed food information
    def food_info(food_id)
      get("/foods/#{food_id}.json")
    end

    # ==========================================
    #           Food Update Methods
    # ==========================================

    # Log food to fitbit for the current user
    #
    # To log a food, either a +foodId+ or +foodName+ is REQUIRED.
    #
    # @param [Hash] opts Food log options
    # @option opts [Integer, String] :foodId Food id
    # @option opts [String] :foodName Food entry name
    # @option opts [String] :brandName Brand name, valid only with foodName
    # @option opts [Integer, String] :calories Calories for this serving size,
    #   valid only with foodName
    # @option opts [Integer, String] :mealTypeId Meal type id; (1 -
    #   Breakfast, 2 - Morning Snack, 3 - Lunch, 4 - Afternoon Snack, 5 - Dinner, 7 - Anytime)
    # @option opts [Integer, String] :unitId Unit id; typically
    #   retrieved via previous calls to {#foods_on_date},
    #   {#recent_foods}, {#favorite_foods}, {#frequent_foods},
    #   {#find_food}, or {#foods_units}
    # @option opts [Integer, Decimal, String] :amount Amount consumed;
    #   if a String, must be in the format "X.XX"
    # @option opts [DateTime, Date, String] :date Log entry date; in the
    #   format "yyyy-MM-dd" if a String
    # @option opts [Boolean] :favorite Add food to favorites after
    #   creating the log
    #
    # @return [Hash] Hash containing confirmation of the logged food
    def log_food(opts)
      post("/user/#{@user_id}/foods/log.json", opts)
    end

    # Mark a food as a favorite
    #
    # @param [Integer, String] food_id Food id
    # @return [Hash] Empty denotes success
    def add_favorite_food(food_id)
      post("/user/#{@user_id}/foods/log/favorite/#{food_id}.json")
    end

    # ==========================================
    #           Food Removal Methods
    # ==========================================

    # Remove a logged food entry
    #
    # @param [Integer, String] food_log_id The ID of the food log, which
    #   is the ID returned in the response when {#log_food} is called.
    # @return [Hash] Empty hash denotes success
    def delete_logged_food(food_log_id)
      delete("/user/#{@user_id}/foods/log/#{food_log_id}.json")
    end

    # Unmark a food as a favorite
    #
    # @param [Integer, String] food_id Food id
    # @return [Hash] Empty hash denotes success
    def remove_favorite_food(food_id)
      delete("/user/#{@user_id}/foods/favorite/#{food_id}.json")
    end

    # ==========================================
    #           Food Creation Methods
    # ==========================================

    # Create a new food and add it to fitbit
    #
    # @param [Hash] opts The data used to create the food
    # @option opts [String] :name Food name
    # @option opts [Integer, String] :defaultFoodMeasurementUnitId Unit id; typically
    #   retrieved via previous calls to {#foods_on_date},
    #   {#recent_foods}, {#favorite_foods}, {#frequent_foods},
    #   {#find_food}, or {#foods_units}
    # @option opts [Integer, String] :defaultServingSize The default
    #   serving size of the food
    # @option opts [Integer, String] :calories The number of calories in
    #   the default serving size
    # @option opts [String] :formType Form type; LIQUID or DRY - use
    #   {Fitgem::FoodFormType#LIQUID} or {Fitgem::FoodFormType#DRY}
    # @option opts [String] :description Food description
    #
    # @return [Hash] If successful, returns a hash containing
    #   confirmation of the food that was added
    def create_food(opts)
      post("/foods.json", opts)
    end
  end
end
