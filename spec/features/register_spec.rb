require 'spec_helper'

feature 'Registering an account' do
  scenario 'a guest can register an account' do
    register_user

    expect(page).to have_content 'Welcome to the newsletter application'
    expect(page).to have_content 'email@email.com'
    expect(page).to have_content 'Logout'
  end

  scenario 'email cannot be blank when trying to register' do
    register_user(:email => '         ')
    expect(page).to have_content "must be a valid email address"
  end

  scenario 'password cannot be blank when trying to register' do
    register_user(:password => '       ')
    expect(page).to have_content "Password can't be blank"
  end

  scenario 'guest cannot register if password field does not match password confirmation field' do
    register_user(:password => 'coolcool')
    expect(page).to have_content "does not match password"
  end

  scenario 'guest cannot register if password is less than 8 chars' do
    register_user(:password => 'skate14', :password_confirmation => 'skate14')
    expect(page).to have_content "Password must be 8 or more characters"
  end

  scenario 'guest cannot register with an email that has been registered before' do
    user = create_user
    register_user(:email => user.email)
    expect(page).to have_content "Email has already been taken"
  end

  scenario 'guest cannot register if email is not valid' do
    register_user(:email => 'example')
    expect(page).to have_content "must be a valid email address"
  end

  scenario 'user can see the terms of service' do
    visit '/terms'
    expect(page).to have_content('Welcome to gSchool Newsletter, a West End Pearl corporation')
  end

  scenario 'user sees error when signing up without agreeing to Terms of Service' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', with: 'email@email.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button 'Register'
    expect(page).to have_content("must be accepted")
  end

  scenario 'A user receives an email after registering' do
    mail_sent = ActionMailer::Base.deliveries.length
    register_user

    expect(ActionMailer::Base.deliveries.length).to eq (mail_sent + 1)
  end
end