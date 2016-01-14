class Recipe < ActiveRecord::Base
  has_many :user_recipes
  has_many :users, through: :user_recipes


  def self.per_recipe_overview
    # select count(*),recipes.title from user_recipes  inner join recipes on user_recipes.recipe_id=recipes.id group by recipe_id
    # select count(*),recipes.title from user_recipes  inner join recipes on user_recipes.recipe_id=recipes.id where favorite=1 group by recipe_id
    result = {}
    Recipe.all.each do |item|
      result[item.title] = []
      result[item.title] << UserRecipe.where(recipe_id: item.id).map(&:user_id).uniq.size
      result[item.title] << UserRecipe.where(recipe_id: item.id).where(favorite: true).map(&:user_id).uniq.size
      result[item.title] << UserRecipe.where(recipe_id: item.id).where(favorite: true).where(activate: true).map(&:user_id).uniq.size
    end
    result
  end

  def self.per_recipe_by_day(start_time, end_time)
    result = {}
    records = UserRecipe.where(created_at: Date.parse(start_time)..Date.parse(end_time))
    Recipe.all.each do |recipe|
      result[recipe.title] = {}
      records.each do |item|
        next if item.recipe_id != recipe.id
        date = item.created_at.to_s[0..9]
        result[recipe.title][date] = 0 if result[recipe.title][date].nil?
        result[recipe.title][date] += 1
      end
    end
    result.each do |k,v|
      v.each do |kk,vv|
        result[k].delete(kk) if vv == 0
      end
    end
    (Date.parse(start_time)..Date.parse(end_time)).each do |item|
      tmp = item.to_s
      Recipe.all.each do |recipe|
        result[recipe.title][tmp] = 0 if result[recipe.title][tmp].nil?
      end
    end
    result
  end

  def self.recipe_count_by_user(admin = 0)
    result = {}
    UserRecipe.all.each do |item|
      user = User.find(item.user_id)
      result["#{user.email}-#{user.name}"] = [] if result["#{user.email}-#{user.name}"].nil?
      result["#{user.email}-#{user.name}"] << Recipe.find(item.recipe_id).try(:title)
    end
    result.sort_by{|k,v| 9 - v.size}
  end
end