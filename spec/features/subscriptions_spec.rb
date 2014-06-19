require 'spec_helper'

feature 'manage subscriptions' do

  before do
    create_user(email: 'non_admin@email.com', password: 'password', admin: false)
    create_publication(:name => 'A Test Publication', :description => 'This is a description')
  end

  scenario 'user can subscribe to a publication not more than once, but can subscribe to multiple publications', js: true do
    VCR.use_cassette('subscription') do
      create_publication(:name => '2nd Publication', :description => 'This is a description')
      visit '/'
      click_on 'Login'
      fill_in 'email', :with => 'non_admin@email.com'
      fill_in 'password', :with => 'password'
      click_on 'login'
      click_on 'All Publications'
      within '.publication_list tr:nth-child(1)' do
        click_on 'Subscribe'
      end
      fill_in 'credit_card_number', with: '4242424242424242'
      fill_in 'cvv', with: '123'
      select "12", from: '_expiry_date_2i'
      select "2015", from: '_expiry_date_1i'

      click_button 'Submit'

      expect(page).to have_content 'My Subscriptions'
      expect(page).to have_content 'Test Publication'
      click_on 'All Publications'
      expect(page).to have_content 'Subscribed'


      within '.publication_list tr:nth-child(2)' do
        click_on 'Subscribe'
      end
      expect(page).to have_content "existing credit card"

      click_button 'Submit'
      expect(page).to have_content '2nd Publication'
    end
  end

  scenario 'A subscription is not made if the card is declined', js: true do
    VCR.use_cassette('subscription_decline') do
      visit '/'
      click_on 'Login'
      fill_in 'email', :with => 'non_admin@email.com'
      fill_in 'password', :with => 'password'
      click_on 'login'
      click_on 'All Publications'
      within '.publication_list tr:nth-child(1)' do
        click_on 'Subscribe'
      end

      fill_in 'credit_card_number', with: '4000000000000002'
      fill_in 'cvv', with: '123'
      select "12", from: '_expiry_date_2i'
      select "2015", from: '_expiry_date_1i'

      click_button 'Submit'
      expect(page).to have_content 'Your card was declined.'
      click_on 'All Publications'
      expect(page).to_not have_content 'Subscribed'
    end
  end

end