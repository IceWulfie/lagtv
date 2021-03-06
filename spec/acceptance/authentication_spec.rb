require 'acceptance/acceptance_helper'

feature 'Users can login' do
  background do
    @user = Fabricate(:user, :email => 'someone@somewhere.com', :password => 'secret', :password_confirmation => 'secret')
  end

  scenario 'allow access given correct username and password' do
    login_as(@user)
    page.should have_content('Logged in successfully!')
  end  

  scenario 'allow access given cases insensitive email' do
    visit root_url
    fill_in 'email', :with => 'Someone@Somewhere.Com'
    fill_in 'password', :with => 'secret'
    click_button 'Login'

    page.should have_content('Logged in successfully!')
  end
end