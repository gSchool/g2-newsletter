require 'spec_helper'

describe Notifier do
  let :user do
    User.create!(email: "password@example.com", password: "password1", password_confirmation: "password1")
  end
  let(:welcome_message) { Notifier.welcome_email(user) }

  it 'comes from correct email address' do
    expect(welcome_message.from).to eq ["notifications@g2-newsletter.com"]
  end

  it 'goes to correct email address' do
    expect(welcome_message.to).to eq ["password@example.com"]
  end

  it 'has a subject' do
    expect(welcome_message.subject).to eq 'Thank you for signing up!'
  end

  it 'has a thank you message in the body' do
    expect(welcome_message.body).to have_content 'Thanks for joining'
  end
end