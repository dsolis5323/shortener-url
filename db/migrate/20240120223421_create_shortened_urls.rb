class CreateShortenedUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :shortened_urls do |t|
      t.text :original_url
      t.string :short_url
      t.text :title
      t.integer :redirects

      t.timestamps
    end
  end
end
