require 'spec_helper'


feature 'Login' do
  scenario 'a registered user can login with the credentials they supplied' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@email.com'
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    click_on 'Register'
    click_on 'Logout'
    visit '/'
    click_on 'Login'
    fill_in 'email', :with => 'email@email.com'
    fill_in 'password', :with => 'password'
    click_on 'login'
    expect(page).to have_content "Welcome back"
  end
  scenario 'a user can logout' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@email.com'
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    click_on 'Register'
    click_on 'Logout'
    expect(page).to_not have_content 'Welcome to the newsletter application'
    expect(page).to have_content 'You have logged out.'
  end
  scenario 'a user cannot register with incorrect password' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@email.com'
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    click_on 'Register'
    click_on 'Logout'
    click_on 'Login'
    fill_in 'email', :with => 'email@email.com'
    fill_in 'password', :with => 'coolcool'
    click_on 'login'
    expect(page).to have_content 'Email or password incorrect'
  end

end