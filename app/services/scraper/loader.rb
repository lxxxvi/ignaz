class Scraper::Loader < Scraper
  def initialize(url)
    @url = url

    super
  end

  def call
    load!
  end

  private

  def load!
    read_csv(get(@url)).each do |row|
      open_zh_row = Scraper::OpenZhRow.new(row)
      covid_case = open_zh_row.to_covid_case
      covid_case.save!
    rescue StandardError => e
      raise Scraper::LoaderError.new(row, e)
    end
  end
end
