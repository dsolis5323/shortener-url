FactoryBot.define do
  factory :shortened_url do
    sequence(:original_url) { |number| "https://www.google.com/search?q=#{number}" }
    sequence(:short_url, &:to_s)
  end
end
