require 'nokogiri'
require 'open-uri'

class PageTitle
  def self.get_title(url)
    URI.parse(url).open do |f|
      doc = Nokogiri::HTML(f)
      return doc.at_css('title').text
    end
    rescue
      return 'Title not found'
  end
end
