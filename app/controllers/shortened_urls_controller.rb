class ShortenedUrlsController < ApplicationController
  def create
    shortened_url = ShortenedUrl.new(original_url: params[:original_url])

    if shortened_url.save
      render json: { short_url: short_url(shortened_url.slug) }, status: :created
    else
      render json: { errors: shortened_url.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def redirect
    shortened_url = ShortenedUrl.find_by(slug: params[:slug])
    return render_404 unless shortened_url

    redirect_to shortened_url.original_url, allow_other_host: true
  end

  private

  def short_url(slug)
    "#{request.base_url}/#{slug}"
  end

  def render_404
    render file: Rails.public_path.join("404.html"), status: :not_found
  end
end
