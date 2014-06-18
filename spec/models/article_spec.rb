require 'spec_helper'

describe Article do

  it 'Email is sent to all publication subscribers when article is added' do
    emails_sent = ActionMailer::Base.deliveries.length
    publication = create_publication
    user1 = create_user
    user2 = create_user(email: 'test@example.com')
    create_subscription(user1.id, publication.id)
    create_subscription(user2.id, publication.id)
    create_article(publication_id: publication.id)
    expect(ActionMailer::Base.deliveries.length).to eq(emails_sent+2)
  end
end