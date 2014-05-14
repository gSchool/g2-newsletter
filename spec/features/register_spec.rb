require 'spec_helper'



feature 'Registering an account' do

  scenario 'a guest can register an account' do
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', :with => 'email@email.com'
    fill_in 'user[password]', :with => 'password'
    click_on 'register'
    expect(page).to have_content 'Welcome email@email.com'

  end
end