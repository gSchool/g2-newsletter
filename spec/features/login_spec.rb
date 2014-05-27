require 'spec_helper'

feature 'Login' do
  scenario 'a registered user can login' do
    visit '/'

    click_on 'Register'
    fill_in 'user[email]', :with => 'paul@paul.com'
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    check 'terms'
    click_button 'Register'
    expect(page).to have_content 'Welcome to the newsletter application'
    click_on 'Logout'
    expect(page).to have_content 'You have logged out.'

    click_on 'Login'
    fill_in 'email', :with => 'paul@paul.com'
    fill_in 'password', :with => 'password'
    click_button 'login'
    expect(page).to have_content 'Welcome back'
    click_on 'Logout'
    expect(page).to have_content 'You have logged out.'
  end
end