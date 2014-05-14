require 'spec_helper'


feature 'User can visit a homepage' do
  scenario 'user goes to root page' do
    visit '/'
    expect(page).to have_content 'Login'

  end
end