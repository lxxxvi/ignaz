namespace :ignaz do
  desc 'Scrape CSVs from openZH/covid_19'
  task scrape: :environment do
    Scraper.call
  end
end
