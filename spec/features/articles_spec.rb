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
  scenario 'User can view details of an article and is sent an email when a new article is created' do
    emails = ActionMailer::Base.deliveries.length
    create_user(email: 'admin@example.com',
                admin: true)
    VCR.use_cassette('subscription') do
      click_on 'All Publications'
      within '.publication_list tr:nth-child(1)' do
        click_on 'Subscribe'
      end
      fill_in 'credit_card_number', with: '4242424242424242'
      fill_in 'cvv', with: '123'
      select "12", from: '_expiry_date_2i'
      select "2015", from: '_expiry_date_1i'

      click_button 'Submit'
      click_on 'More info'
      click_link 'Article Title'
      expect(page).to have_content 'Article Title'
      expect(page).to have_content 'Article Description'
    end

    click_on 'Logout'

    login_user(email: 'admin@example.com')
    click_on 'All Publications'
    click_on 'More info'
    click_on 'Add article'

    fill_in 'Title', with: 'Article 1'
    fill_in 'Description', with: 'This is article 1'
    click_on 'Add Article'
    article = Article.last
    users = article.publication.subscriptions.includes(:user).map { |sub| sub.user }

    expect(users.count).to eq(1)
    expect(ActionMailer::Base.deliveries.length).to eq(emails + 1)
  end

  scenario 'User cannot view details of an article if they are not subscribed' do
    click_on 'All Publications'
    click_on 'More info'
    click_link 'Article Title'
    page.status_code.should == 404
  end
end
