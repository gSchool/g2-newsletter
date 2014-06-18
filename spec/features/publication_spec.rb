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
  end

  scenario 'Admin can create an article' do
    visit '/'
    click_on 'Login'
    fill_in 'email', :with => 'admin@email.com'
    fill_in 'password', :with => 'password'
    click_on 'login'
    expect(page).to have_content 'Welcome back admin@email.com'
    click_on 'All Publications'
    click_on 'More info'
    click_on 'Add article'
    fill_in 'article[title]', with: 'Rails'
    fill_in 'article[description]', with: 'How to Code'
    click_on 'Add Article'
    expect(page).to have_content 'Rails'
  end
end


feature 'Guest' do
  before do
    create_publication(:name => 'Test Publication', :description => 'This is a description')
  end
  scenario 'can view the show page for a publication by clicking on it' do
    visit '/'
    click_on 'More Info'
    expect(page).to have_content 'This is a description'
  end
end

