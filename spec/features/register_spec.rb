require 'spec_helper'

feature 'Registering an account' do
  scenario 'a guest can register an account' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@email.com'
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    click_on 'register'
    expect(page).to have_content 'Welcome email@email.com'
  end

  scenario 'a guest can logout' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@email.com'
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    click_on 'register'
    expect(page).to have_content 'Welcome email@email.com'
    click_on 'Logout'
    expect(page).to_not have_content 'email@email.com'
  end

  scenario 'email cannot be blank when trying to register' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => '  '
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    click_on 'register'
    expect(page).to have_content "Email can't be blank"
  end

  scenario 'password cannot be blank when trying to register' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@example.com'
    fill_in 'user[password]', :with => '  '
    fill_in 'user[password_confirmation]', :with => ' '
    click_on 'register'
    expect(page).to have_content "Password can't be blank"
  end

end