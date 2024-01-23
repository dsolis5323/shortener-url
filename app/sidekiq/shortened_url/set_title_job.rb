class ShortenedUrl::SetTitleJob
  include Sidekiq::Job

  def perform(shortened_url_id)
    shortened_url = ShortenedUrl.find(shortened_url_id)
    shortened_url.update_title!
    shortened_url.save
  end
end
