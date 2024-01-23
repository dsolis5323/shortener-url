class ShortenedUrl::SetTitleJob
  include Sidekiq::Job

  def perform(shortened_url_id)
    shortened_url = ShortenedUrl.find(shortened_url_id)
    title = PageTitle.get_title(shortened_url.original_url)
    shortened_url.update(title: title) unless title.blank?
  end
end
