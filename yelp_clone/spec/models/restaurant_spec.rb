require 'rails_helper'

describe Restaurant, type: :model do
  it "Is not valid with a name less that 3 characters" do
    r = Restaurant.new(name: 'KF')
    expect(r).to have(1).error_on(:name)
    expect(r).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
    user = User.create(email: "testtest@example.com", password: "testtest")
    user.restaurants.create(name: "Moe's Tavern")
    restaurant = user.restaurants.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

  describe 'reviews' do
    describe 'build_with_user' do
      let(:user) { User.create email: 'test@test.com'}
      let(:restaurant) {Restaurant.create name: 'Test'}
      let(:review_params) { {rating: 5, thoughts: 'yum'}}

      subject(:review) {restaurant.reviews.build_with_user(review_params, user)}

      it 'build a review' do
        expect(review).to be_a Review
      end

      it 'build a review associated with the specified user' do
        expect(review.user).to eq user
      end
    end
  end


end
