class ShortenedUrl < ApplicationRecord
  validates :original_url, presence: true,
    format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug, on: :create

  private

  def generate_slug
    return if slug.present?

    loop do
      self.slug = SecureRandom.alphanumeric(6).downcase
      break unless ShortenedUrl.exists?(slug: slug)
    end
  end
end
