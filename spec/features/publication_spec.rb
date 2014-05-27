require 'spec_helper'

feature 'Admin' do
  before do
    create_user(email: 'admin@email.com', password: 'password', admin: true)
    create_user(email: 'non_admin@email.com', password: 'password', admin: false)
    create_publication(:name => 'Test Publication', :description => 'This is a description')
  end
  scenario 'can view a page to manage publications' do
    visit '/'
    click_on 'Login'
    fill_in 'email', :with => 'admin@email.com'
    fill_in 'password', :with => 'password'
    click_on 'login'
    expect(page).to have_content 'Welcome back admin@email.com'
    click_on 'All Publications'
    click_on 'Add Publication'
    fill_in 'publication[name]', :with => 'Publication One'
    fill_in 'publication[description]', :with => 'This is a description'
    click_on 'Create Publication'
    expect(page).to have_content 'Publication One'

  end
  scenario 'a non admin cannot add a publication' do
    visit '/'
    click_on 'Login'
    fill_in 'email', :with => 'non_admin@email.com'
    fill_in 'password', :with => 'password'
    click_on 'login'
    expect(page).to have_content 'Welcome back non_admin@email.com'
    expect(page).to have_no_content 'Manage Publications'
  end
  feature 'Guest' do
    scenario 'can view the show page for a publication by clicking on it' do
      visit '/'
      click_on 'Test Publication'
      expect(page).to have_content 'This is a description'
    end
  end
end