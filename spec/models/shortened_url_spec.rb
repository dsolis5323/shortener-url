require 'rails_helper'

RSpec.describe ShortenedUrl, type: :model do
  describe 'Validations' do
    subject { FactoryBot.build(:shortened_url) }

    it { is_expected.to validate_presence_of(:original_url) }
    it { is_expected.to validate_uniqueness_of(:original_url).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:short_url).case_insensitive }
  end
end
