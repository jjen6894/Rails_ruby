require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add restaurants' do
      visit '/restaurants'
      sign_up
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end
end

  context 'restaurants have been added' do
    before do
      sign_up
      add_restaurant
    end
    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content("KFC")
      expect(page).not_to have_content("No restaurants yet")
    end
  end

  context 'creating restaurants' do
  scenario 'prompts user to fill out a form, then displays the new restaurant' do
    visit '/restaurants'
    sign_up
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
    expect(page).to have_content('KFC')
    expect(current_path).to eq '/restaurants'
  end

  context 'an invalid restaurant' do
    scenario 'does not let you submit a name that is too short' do
      visit('/restaurants')
      sign_up
      click_link("Add a restaurant")
      fill_in("Name", with: "KF")
      click_button("Create Restaurant")

      expect(page).not_to have_css("h2", text: "KF")
      expect(page).to have_content("Error")
    end
  end
end

context 'viewing restaurants' do

  scenario 'lets a user view a restaurant' do
    sign_up
    add_restaurant
    visit '/restaurants'
    click_link ('KFC')
    expect(page).to have_content('KFC')
    expect(current_path).to eq("/restaurants/#{User.first.restaurants[0].id}")
  end

  scenario 'lets guest users only see list of restaurants' do
    sign_up
    add_restaurant
    click_link 'Sign out'
    expect(page).not_to have_link("Add a restaurant")
    expect(page).to have_content("KFC")
  end

end


context 'editing restaurants' do

  scenario 'let a user edit a restaurant' do
    sign_up
    add_restaurant
    click_link('Edit KFC')
    fill_in('Name', with: 'Kentucky Fried Chicken')
    fill_in('Description', with: 'Deep Fried Goodness')
    click_button('Update Restaurant')
    click_link('Kentucky Fried Chicken')
    expect(page).to have_content('Kentucky Fried Chicken')
    expect(page).to have_content('Deep Fried Goodness')
    expect(current_path).to eq("/restaurants/#{User.first.restaurants[0].id}")
  end

  scenario 'user can only edit the restaurants it created' do
    sign_up
    add_restaurant
    click_link 'Sign out'
    sign_up2
    click_link 'Edit KFC'
    expect(page).to have_content "You can only edit the restaurants you've created."
    expect(current_path).to eq("/restaurants")
  end
end

context 'deleting restaurants' do

  scenario 'removes a restaurant when a user clicks a delete link' do
    sign_up
    add_restaurant
    click_link('Delete KFC')
    expect(page).not_to have_content('KFC')
    expect(page).to have_content('Restaurant deleted successfully')
  end

  scenario 'user can only delete the restaurants it created' do
    sign_up
    add_restaurant
    click_link 'Sign out'
    sign_up2
    click_link 'Delete KFC'
    expect(page).to have_content "You can only delete the restaurants you've created."
    expect(current_path).to eq("/restaurants")
  end
end
