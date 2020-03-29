require 'net/http'
require 'csv'

class Scraper
  def get(url)
    self.class.get(url)
  end

  def self.get(url)
    Net::HTTP.get(URI(url))
  end

  def self.call
    Scraper::Urls.all.each do |url|
      puts "Processing #{url}"
      Scraper::Loader.new(url).call
    end
  end

  private

  def read_csv(content)
    CSV.new(content, headers: true)
  end
end
