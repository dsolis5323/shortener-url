class CreateShortenedUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :shortened_urls do |t|
      t.text :original_url, null: false
      t.string :short_url
      t.text :title
      t.integer :redirects, default: 0, null: false

      t.timestamps
    end
  end
end
