class Scraper::Error < StandardError
  def initialize(url, error)
    msg = "URL: #{url}\n\n#{error.message}"

    super msg
  end
end
