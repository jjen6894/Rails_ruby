def sign_up
  visit '/'
  click_link('Sign up')
  fill_in 'Email', with: 'test@example.com'
  fill_in 'Password', with: 'testtest'
  fill_in 'Password confirmation', with: 'testtest'
  click_button 'Sign up'
end

def sign_up2
  visit '/'
  click_link('Sign up')
  fill_in 'Email', with: 'testtest@example.com'
  fill_in 'Password', with: 'testtesttest'
  fill_in 'Password confirmation', with: 'testtesttest'
  click_button 'Sign up'
end

def add_restaurant
    visit '/'
    click_link('Add a restaurant')
    fill_in 'Name', with: 'KFC'
    fill_in 'Description', with: 'Fried Chicken'
    click_button 'Create Restaurant'
end
