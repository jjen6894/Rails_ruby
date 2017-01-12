class RestaurantsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def user
    @user ||= current_user
  end

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    user
    @restaurant= user.restaurants.new(restaurant_params)
    if @restaurant.save
      redirect_to '/restaurants'
    else
      render "new"
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    unless user.restaurants.include?(@restaurant)
      flash[:notice] = "You can only edit the restaurants you've created."
      redirect_to restaurants_path
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to '/restaurants'
  end

  def destroy
    user = current_user if current_user
    @restaurant = Restaurant.find(params[:id])
    if user.restaurants.include?(@restaurant)
      @restaurant.destroy
      flash[:notice] = "Restaurant deleted successfully"
      redirect_to("/restaurants")
    else
      flash[:notice] = "You can only delete the restaurants you've created."
      redirect_to restaurants_path
    end
  end

private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description)
  end
end
