require 'rails_helper'

feature 'restaurants' do
  context 'when no restaurants have been added' do
    it 'should display a prompt for adding a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end
end
