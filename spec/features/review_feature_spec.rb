require 'rails_helper'

feature 'Reviews' do
  before { Restaurant.create name: 'KFC' }

  context 'allows users to leave a review' do
    scenario "leaving a review" do
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in 'Thoughts', with: 'so-so'
      select '3', from: 'Rating'
      click_button 'Leave review'

      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'so-so'
    end
  end
end
