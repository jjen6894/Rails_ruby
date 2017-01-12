class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
<<<<<<< HEAD
    
    @restaurant.reviews.create(review_params)
    redirect_to("/restaurants")
=======
    @review = @restaurant.build_review(review_params, current_user)
    if @review.save
      redirect_to '/restaurants'
    else
      if @review.errors[:user]
        redirect_to '/restaurants'; flash[:notice] = "Has reviewed this restaurant already"
      else
        render :new
      end
    end
>>>>>>> bf78f8d25c412e873e5b2a2c9aa242acfb8cac62
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
