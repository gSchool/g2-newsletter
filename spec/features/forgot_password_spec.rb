require 'spec_helper'


feature 'User' do

  scenario 'can vist a page with a form for forgotten password' do
   user = create_user
    visit '/'
    click_on 'Login'
    click_on 'Forgot Password?'
    fill_in 'user[email]', :with => "#{user.email}"
    click_on 'Send Password Reset Instructions'
    expect(page).to have_content 'Email with instructions on reseting your password has been sent'
  end
  
end