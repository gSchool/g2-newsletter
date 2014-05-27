require 'spec_helper'

feature 'Registering an account' do
  scenario 'a guest can register an account' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@email.com'
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    check 'terms'
    click_button 'Register'
    expect(page).to have_content 'Welcome to the newsletter application'
    expect(page).to have_content 'email@email.com'
    expect(page).to have_content 'Logout'
  end

  scenario 'a guest can logout' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@email.com'
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    check 'terms'
    click_button 'Register'
    expect(page).to have_content 'Welcome to the newsletter application'
    expect(page).to have_content 'email@email.com'
    click_on 'Logout'
    expect(page).to_not have_content 'email@email.com'
  end


  scenario 'email cannot be blank when trying to register' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => '         '
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    check 'terms'
    click_button 'Register'
    expect(page).to have_content "must be a valid email address"
  end

  scenario 'password cannot be blank when trying to register' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@example.com'
    fill_in 'user[password]', :with => '        '
    fill_in 'user[password_confirmation]', :with => '        '
    click_button 'Register'
    expect(page).to have_content "Password can't be blank"
  end

  scenario 'guest cannot register if password field does not match password confirmation field' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@example.com'
    fill_in 'user[password]', :with => 'coolcool'
    fill_in 'user[password_confirmation]', :with => 'whatever'
    click_button 'Register'
    expect(page).to have_content "does not match password"
  end

  scenario 'guest cannot register if password is less than 8 chars' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@example.com'
    fill_in 'user[password]', :with => 'cool'
    fill_in 'user[password_confirmation]', :with => 'cool'
    click_button 'Register'
    expect(page).to have_content "Password must be 8 or more characters"
  end

  scenario 'guest cannot register with an email that has been registered before' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@example.com'
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    check 'terms'
    click_button 'Register'
    click_on 'Logout'
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@example.com'
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    check 'terms'
    click_button 'Register'
    expect(page).to have_content "Email has already been taken"
  end

  scenario 'guest cannot register if email is not valid' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'example'
    fill_in 'user[password]', :with => 'coolcool'
    fill_in 'user[password_confirmation]', :with => 'coolcool'
    check 'terms'
    click_button 'Register'
    expect(page).to have_content "must be a valid email address"
  end

  scenario 'user can see a link to terms of service' do
    visit '/users/new'
    click_on 'Terms of Service'
    expect(page).to have_content('Welcome to gSchool Newsletter, a West End Pearl corporation')
  end

  scenario 'user sees error when signing up without agreeing to Terms of Service' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', with: 'paul@email.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button 'Register'
    expect(page).to have_content("must be accepted")
  end
end