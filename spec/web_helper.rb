def sign_up email = 'test@test.com'
  visit '/users/sign_up'
  fill_in 'user_email', with: email
  fill_in 'user_password', with: 'password'
  fill_in 'user_password_confirmation', with: 'password'
  click_button 'Sign up'

end

def list_KFC
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'restaurant_name', with: 'KFC'
  fill_in 'restaurant_description', with: 'Deep fried goodness'
  click_button 'Create Restaurant'

end
