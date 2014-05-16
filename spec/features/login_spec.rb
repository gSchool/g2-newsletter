require 'spec_helper'


feature 'Login' do
  scenario 'a registered user can login with the credentials they supplied' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@example.com'
    fill_in 'user[password_digest]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    click_on 'register'
    click_on 'Logout'
    visit '/'
    click_on 'Login'
    fill_in 'email', :with => 'email@example.com'
    fill_in 'password_digest', :with => 'password'
    click_on 'login'
    expect(page).to have_content "Welcome back email@example.com"
    end
end