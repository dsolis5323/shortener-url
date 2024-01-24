require 'rails_helper'
require 'sidekiq/testing'

TITLE = 'Mocked title'.freeze

RSpec.describe ShortenedUrlJobs::SetTitleJob, type: :job do
  describe '#perform' do
    it 'prints a greeting' do
      Sidekiq::Testing.inline! do
        new_url = create(:shortened_url)
        allow(PageTitle).to receive(:get_title).and_return(TITLE)
        described_class.perform_async(new_url.id)
        new_url.reload

        expect(new_url.title).to eq(TITLE)
      end
    end
  end
end
