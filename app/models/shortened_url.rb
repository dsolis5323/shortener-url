require 'nokogiri'
require 'open-uri'

class ShortenedUrl < ApplicationRecord
  validates :original_url, presence: true, uniqueness: true, http_url: true, on: :create
  validates :short_url, uniqueness: true, allow_nil: true
  after_create :generate_short_url

  ALPHABET = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.chars

  def generate_short_url
    index = id
    new_url = ''
    base = ALPHABET.length

    while index.positive?
      new_url << ALPHABET[index.modulo(base)]
      index /= base
    end
    update(short_url: new_url)
  end
end
