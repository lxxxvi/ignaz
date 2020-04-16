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
    errors = []

    CovidCase.transaction do
      CovidCase.connection.execute("DELETE FROM #{CovidCase.table_name}")

      Scraper::Urls.all.each do |url|
        puts "Processing #{url}"
        Scraper::Loader.new(url).call
      rescue Scraper::LoaderError => e
        errors << Scraper::Error.new(url, e)
      end
    end

    DeltaColumnsUpdater.call

    if errors.any?
      puts "There were #{errors.count} errors"
      puts errors.join("\n")
      Bugsnag.notify(errors.join("\n"))
      exit 9
    end
  end

  private

  def read_csv(content)
    CSV.new(content, headers: true)
  end
end
