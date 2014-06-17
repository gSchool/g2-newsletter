require 'spec_helper'

feature 'Login' do
  scenario 'a registered user can login' do
    register_user
    expect(page).to have_content 'Welcome to the newsletter application'
    click_on 'Logout'
    expect(page).to have_content 'You have logged out'

    login_user
    expect(page).to have_content 'Welcome back'
  end

  scenario 'User can see a list of publications they are subscribed to' do
    visit root_path
    register_user
    expect(page).to have_link 'My Subscriptions'
  end

end

feature 'Session Expiration' do
  include ActiveSupport::Testing::TimeHelpers
  scenario 'a session will expire after 24 hours' do
    user = create_user
    login_user(:email => user.email, :password => user.password)
    sleep 1
    travel_to(1.day.from_now)
    visit '/'
    expect(page).to have_content 'Your session has expired'
  end
end