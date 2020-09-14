namespace :ignaz do
  desc 'Scrape CSVs from openZH/covid_19'
  task scrape: :environment do
    scraper = Scraper.new
    scraper.call

    if scraper.errors.any?
      Rails.logger.error("There were #{scraper.errors.count} errors")
      Rails.logger.error(scraper.errors.join("\n"))
      Bugsnag.notify(errors.join("\n"))
      exit 9
    end
  end
end
