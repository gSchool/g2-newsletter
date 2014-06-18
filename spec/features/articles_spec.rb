require 'spec_helper'

feature 'Create Articles' do
  before do
    create_publication
  end
  scenario 'Guests and users are not able to create articles' do
    visit '/'
    click_on 'More Info'
    expect(page).to_not have_link 'Add article'
    register_user
    click_on 'All Publications'
    click_on 'More info'
    expect(page).to_not have_link 'Add article'
  end
end

feature 'User can view articles' do
  before do
    create_publication
    create_article
    register_user
  end
  scenario 'User can view details of an article' do
    click_on 'All Publications'
    click_on 'Subscribe'
    click_on 'More info'
    click_link 'Article Title'
    expect(page).to have_content 'Article Title'
    expect(page).to have_content 'Article Description'
  end

  scenario 'User cannot view details of an article if they are not subscribed' do
    click_on 'All Publications'
    click_on 'More info'
    click_link 'Article Title'
    page.status_code.should == 404
  end
end