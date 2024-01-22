class ShortenedUrl < ApplicationRecord
  validates :original_url, presence: true, on: :create
  after_create :generate_short_url

  ALPHABET = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.split(//)

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

  def new_url?
    ShortenedUrl.find_by(original_url:).nil?
  end
end
