require 'rails_helper'

describe Review, type: :model do

  it "should be invalid for ratings above 5" do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end

end
