class RecipeController < ApplicationController
  def index
    @recipes = Recipe.all
    @recipe_overview = Recipe.per_recipe_overview
    @recipe_create_by_day = Recipe.per_recipe_by_day('2015-10-01','2015-11-01')
    @user_recipes = Recipe.recipe_count_by_user
  end
end
