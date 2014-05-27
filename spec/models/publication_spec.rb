require 'spec_helper'

describe Publication do
  describe 'Validations' do
    let(:publication) {create_publication}
    let(:publication2) {new_publication(:name => '')}

    it 'can create a valid publication' do
        expect(publication).to be_valid
    end
    it 'is not a valid publication with a blank name' do
      expect(publication2).to_not be_valid
    end
  end
end
