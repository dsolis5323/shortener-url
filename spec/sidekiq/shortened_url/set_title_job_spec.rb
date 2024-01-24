require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe ShortenedUrl::SetTitleJob, type: :job do
  describe '#perform' do
    it 'prints a greeting' do
      Sidekiq::Testing.inline! do
        TITLE = 'Mocked title'.freeze
        new_url = FactoryBot.create(:shortened_url)
        allow(PageTitle).to receive(:get_title).and_return(TITLE)
        ShortenedUrl::SetTitleJob.perform_async(new_url.id)
        new_url.reload

        expect(new_url.title).to eq(TITLE)
      end
    end
  end
end
