require 'net/http'
require 'csv'

class Scraper
  attr_reader :errors

  def initialize
    @errors = []
  end

  def call
    scrape_urls

    NullGapsFiller.call
    DeltasCalculator.call
  end

  private

  def scrape_urls
    CovidCase.transaction do
      CovidCase.connection.execute("DELETE FROM #{CovidCase.table_name}")

      Scraper::Urls.all.each do |url|
        Rails.logger.info "Processing #{url}"
        Scraper::Loader.new(url).call
      rescue Scraper::LoaderError => e
        @errors << Scraper::Error.new(url, e)
      end
    end
  end
end
