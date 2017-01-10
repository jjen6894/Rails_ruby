class Restaurant < ApplicationRecord
  def index
    @restaurants = Restaurant.all
  end
end
