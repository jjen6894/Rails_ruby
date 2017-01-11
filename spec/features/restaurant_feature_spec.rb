require 'rails_helper'

feature 'restaurants' do
  context 'when no restaurants have been added' do
    scenario 'should display a prompt for adding a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'diplay a list of restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'KFC'
      expect(page).not_to have_content 'No restaurants yet'
    end
  end

  context 'create restaurant' do
    scenario 'user creates a restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: "KFC"
      fill_in 'Description', with: "filthy chick3n lmao"
      click_button 'Create Restaurant'
      expect(page).to have_content "KFC"
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'viewing a restaurant' do
    let!(:kfc){ Restaurant.create(name: 'KFC', description: "filthy chick3n lmao")}

    scenario "user views a restaurant" do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(page).to have_content "filthy chick3n lmao"
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
    before {Restaurant.create name: 'KFC', description: "Deep fried goodness", id: 1}

    scenario "editing a restaurant" do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      click_link 'Kentucky Fried Chicken'
      expect(page).to have_content "Kentucky Fried Chicken"
      expect(page).to have_content "Deep fried goodness"
      expect(current_path).to eq restaurant_path(1)
    end
  end

  context 'deleting restaurants' do
    before {Restaurant.create name: "KFC", description: "Deep friend goodness"}

    scenario "deleting a restaurant" do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end
end
