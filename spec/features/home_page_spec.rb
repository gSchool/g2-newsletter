require 'spec_helper'

feature 'Guest' do
  scenario 'can visit the root page' do
    visit '/'
    expect(page).to have_content 'Login'
    expect(page).to have_content 'Newsletter'
  end
end

