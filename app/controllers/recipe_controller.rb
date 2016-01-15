class RecipeController < ApplicationController
  def index
    @recipes = Recipe.all
    @recipe_overview = Recipe.per_recipe_overview
    @recipe_create_by_day = Recipe.per_recipe_by_day('2015-12-01','2016-01-10')
    @user_recipes = Recipe.recipe_count_by_user
  end
end
