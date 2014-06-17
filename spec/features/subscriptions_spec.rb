require 'spec_helper'

feature 'manage subscriptions' do

  before do
    create_user(email: 'non_admin@email.com', password: 'password', admin: false)
    create_publication(:name => 'Test Publication', :description => 'This is a description')

  end

  scenario 'user can subscribe to a publication' do
    visit '/'
    click_on 'Login'
    fill_in 'email', :with => 'non_admin@email.com'
    fill_in 'password', :with => 'password'
    click_on 'login'
    click_on 'All Publications'
    click_on 'Subscribe'
    expect(page).to have_content 'My Subscriptions'
    expect(page).to have_content 'Test Publication'
  end

  scenario 'user cannot subscribe to the same publication more than once' do
    visit '/'
    click_on 'Login'
    fill_in 'email', :with => 'non_admin@email.com'
    fill_in 'password', :with => 'password'
    click_on 'login'
    click_on 'All Publications'
    click_on 'Subscribe'
    click_on 'All Publications'
    expect(page).to have_content 'Subscribed'
  end

  scenario 'user can see a more info link next to their subscriptions' do
    visit '/'
    click_on 'Login'
    fill_in 'email', :with => 'non_admin@email.com'
    fill_in 'password', :with => 'password'
    click_on 'login'
    click_on 'All Publications'
    click_on 'Subscribe'
    expect(page).to have_content 'My Subscriptions'
    expect(page).to have_content 'Test Publication'
    expect(page).to have_link 'More info'
  end
end