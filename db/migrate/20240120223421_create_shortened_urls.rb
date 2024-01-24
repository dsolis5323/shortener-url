class CreateShortenedUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :shortened_urls do |t|
      t.string :original_url, null: false, limit: 2048
      t.string :short_url, index: { unique: true, name: 'unique_short_url' }
      t.text :title
      t.integer :redirects, default: 0, null: false

      t.timestamps
    end
  end
end
