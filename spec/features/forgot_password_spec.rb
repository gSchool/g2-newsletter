require 'spec_helper'

feature 'User' do

  before do
    @user = create_user
    visit '/'
    @emails_sent = ActionMailer::Base.deliveries.length
    click_on 'Login'
    click_on 'Forgot Password?'
  end

  scenario 'user sent email and given message when when email entered' do
    fill_in 'user[email]', :with => "#{@user.email}"
    click_on 'Send Password Reset Instructions'
    expect(page).to have_content 'Email with instructions on reseting your password has been sent'
    expect(ActionMailer::Base.deliveries.length).to eq (@emails_sent + 1)
  end

  scenario 'message sent if email that does not exist it database given' do
    fill_in 'user[email]', :with => 'not_in_database@example.com'
    click_on 'Send Password Reset Instructions'
    expect(page).to have_content 'Email with instructions on reseting your password has been sent'
    expect(ActionMailer::Base.deliveries.length).to eq (@emails_sent)
  end

  scenario 'invalid email given' do
    fill_in 'user[email]', :with => 'something'
    click_on 'Send Password Reset Instructions'
    expect(page).to have_content 'Please enter a valid email address'
  end

  scenario 'no email is given' do
    fill_in 'user[email]', :with => ''
    click_on 'Send Password Reset Instructions'
    expect(page).to have_content 'Please enter a valid email address'
  end
end
