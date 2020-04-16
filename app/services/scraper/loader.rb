class Scraper::Loader < Scraper
  def initialize(url)
    @url = url
  end

  def call
    CovidCase.transaction do
      purge!
      load!
    end
  end

  private

  def purge!
    CovidCase.connection.execute("DELETE FROM #{CovidCase.table_name}")
  end

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
