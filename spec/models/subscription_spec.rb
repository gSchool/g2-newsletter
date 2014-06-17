require 'spec_helper'

describe Subscription do
  describe 'Validations' do
    let(:publication) { create_publication }
    let(:user) { create_user }
    let(:subscription) { create_subscription(user.id, publication.id) }
    let(:subscription2) { create_subscription(nil, publication.id) }
    let(:subscription3) { create_subscription(user.id, nil) }

    it 'can create a valid subscription' do
      expect(subscription).to be_valid
    end

    it 'is not a valid subscription when user_id is missing' do
      expect(subscription2).to_not be_valid
    end

    it 'is not a valid subscription when publication_id is missing' do
      expect(subscription2).to_not be_valid
    end
  end
end
