class CreateShortenedUrls < ActiveRecord::Migration[7.2]
  def change
    create_table :shortened_urls do |t|
      t.string :original_url, null: false
      t.string :slug, null: false
      t.timestamps
    end
    add_index :shortened_urls, :slug, unique: true
  end
end
