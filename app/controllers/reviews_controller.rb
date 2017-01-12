class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find params[:restaurant_id]
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    if user_signed_in?
      @restaurant.reviews.create(review_params)
    else
      flash[:error] = "You must be signed in to post reviews"
    end
    redirect_to '/restaurants'
  end

  private
  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
