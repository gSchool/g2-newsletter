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
    fill_in 'user[email]', :with => '         '
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    click_on 'register'
    expect(page).to have_content "Must be a valid email address"
  end

  scenario 'password cannot be blank when trying to register' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@example.com'
    fill_in 'user[password]', :with => '        '
    fill_in 'user[password_confirmation]', :with => '        '
    click_on 'register'
    expect(page).to have_content "Password can't be blank"
  end

  scenario 'guest cannot register if password field does not match password confirmation field' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@example.com'
    fill_in 'user[password]', :with => 'cool'
    fill_in 'user[password_confirmation]', :with => 'whatever'
    click_on 'register'
    expect(page).to have_content "Passwords must match"
  end

  scenario 'guest cannot register if password is less than 8 chars' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@example.com'
    fill_in 'user[password]', :with => 'cool'
    fill_in 'user[password_confirmation]', :with => 'cool'
    click_on 'register'
    expect(page).to have_content "Password must be longer than 8 characters"
  end

  scenario 'guest cannot register with an email that has been registered before' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@example.com'
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    click_on 'register'
    click_on 'Logout'
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@example.com'
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    click_on 'register'
    expect(page).to have_content "Email has already been taken"
  end

  scenario 'guest cannot register if email is not valid' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'example'
    fill_in 'user[password]', :with => 'coolcool'
    fill_in 'user[password_confirmation]', :with => 'coolcool'
    click_on 'register'
    expect(page).to have_content "Must be a valid email address"
  end

end