require 'rails_helper'

RSpec.describe ShortenedUrlsController, type: :controller do
  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns all shortened_urls to @shortened_urls' do
      new_url = create(:shortened_url)

      get :index
      expect(assigns(:shortened_urls)).to contain_exactly(new_url)
    end
  end

  describe 'GET #show' do
    it 'redirects and add a redirect count' do
      new_url = create(:shortened_url)

      get :show, params: { short_url: new_url.short_url }
      new_url.reload
      expect(new_url.redirects).to eq(1)
      expect(response).to redirect_to(new_url.original_url)
    end
  end

  describe 'POST #create' do
    it 'adds a new shortened_url and redirect and redirect to top' do
      url_params = { shortened_url: { original_url: 'https://wwww.google.com' } }

      expect do
        post :create, params: url_params
      end.to change(ShortenedUrl, :count).by(1)

      expect(response.status).to eq(302)
      expect(response).to redirect_to('/top-100')
    end

    it 'shoulds fails and stay in the same page' do
      url_params = { shortened_url: { original_url: '' } }

      expect do
        post :create, params: url_params
      end.not_to change(ShortenedUrl, :count)

      expect(response.status).to eq(422)
      expect(response).not_to redirect_to('/top-100')
    end
  end
end

#       it 'routes POST /shortened_urls to the shortened_url#create action' do
#         expect(post: '/shortened_urls').to route_to('shortened_urls#create')
#       end
#     end
#   end
