require 'rails_helper'

RSpec.describe 'ShortenedUrlRouting', type: :routing do
  describe 'routes for ShortenedUrl' do
    it 'routes GET / "root" to the shortened_url#new action' do
      expect(get: '/').to route_to('shortened_urls#new')
    end

    it 'routes GET /:short_url to the shortened_url#show action' do
      expect(get: '/a').to route_to('shortened_urls#show', short_url: 'a')
    end

    it 'routes GET /top-100 to the shortened_url#index action' do
      expect(get: '/top-100').to route_to('shortened_urls#index')
    end

    it 'routes POST /shortened_urls to the shortened_url#create action' do
      expect(post: '/shortened_urls').to route_to('shortened_urls#create')
    end
  end
end
