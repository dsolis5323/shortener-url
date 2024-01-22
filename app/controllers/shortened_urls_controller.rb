class ShortenedUrlsController < ApplicationController
  before_action :set_shortened_url, only: %i[show]

  # GET /shortened_urls or /shortened_urls.json
  def index
    @shortened_urls = ShortenedUrl.order('redirects desc').limit(100)
  end

  # GET /shortened_urls/1 or /shortened_urls/1.json
  def show
    @shortened_url.update(redirects: @shortened_url.redirects + 1)
    redirect_to @shortened_url.original_url, allow_other_host: true
  end

  # GET /shortened_urls/new
  def new
    @shortened_url = ShortenedUrl.new
  end

  # POST /shortened_urls or /shortened_urls.json
  def create
    @shortened_url = ShortenedUrl.new(shortened_url_params)

    respond_to do |format|
      if @shortened_url.save
        format.html do
          redirect_to(
            '/top-100',
            notice: "Shortened url was successfully created: #{@shortened_url.original_url} to #{@shortened_url.short_url}"
          )
        end
        format.json { render :show, status: :created, location: @shortened_url }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shortened_url.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_shortened_url
    @shortened_url = ShortenedUrl.find_by(short_url: params[:short_url])
  end

  # Only allow a list of trusted parameters through.
  def shortened_url_params
    params.require(:shortened_url).permit(:original_url)
  end
end
