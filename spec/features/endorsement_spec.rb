require 'rails_helper'

feature 'endorsing reviews' do
  before do
    user = User.create(email: "test@example.com", password: "testtest")
    kfc = user.restaurants.create(name: 'KFC')
    kfc.reviews.create(rating: 1, thoughts: 'It was an abomination')
  end

  scenario 'a user can endorse a review, which updates the review endorsement count' do
    visit '/restaurants'
    click_link 'Endorse Review'
    expect(page).to have_content('1 endorsement')
  end

end
