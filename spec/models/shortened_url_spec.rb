require 'rails_helper'

ID = 999 # random high id so we do not repeat ids.
SHORT_URL = 'hq'.freeze # result url for 999 id

RSpec.describe ShortenedUrl do
  describe 'Validations' do
    subject { build(:shortened_url) }

    it { is_expected.to validate_presence_of(:original_url) }
    it { is_expected.to validate_length_of(:original_url).is_at_most(2048) }
    it { is_expected.to validate_uniqueness_of(:original_url).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:short_url).case_insensitive }
  end

  describe 'Custom Url Validations' do
    it 'fails url validation' do
      new_url = build(:shortened_url, original_url: 'abc')
      expect(new_url.valid?).to be(false)
      expect(new_url.errors[:original_url]).to eq(['is not a valid HTTP URL'])
    end

    it 'passes url validation' do
      new_url = build(:shortened_url)
      expect(new_url.valid?).to be(true)
    end
  end

  describe 'Generate short url' do
    it 'fails url validation' do
      new_url = create(:shortened_url, id: ID)
      expect(new_url.short_url).to eq(SHORT_URL)
    end
  end
end
