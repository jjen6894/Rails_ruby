require 'rails_helper'

feature 'Reviews' do
  before { sign_up; list_KFC }

  scenario 'allows users to leave a review' do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in 'Thoughts', with: 'so-so'
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'so-so'
  end

  scenario "user can only leave one review per restaurant" do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so-so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so-so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(page).to have_content "You have already reviewed this restaurant"
  end

  scenario "Users can only delete their own reviews" do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so-so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Delete review'
    expect(page).not_to have_content 'so-so'
  end

end
