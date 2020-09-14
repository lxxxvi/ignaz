class Scraper::Loader
  def initialize(url)
    @url = url
  end

  def call
    read_csv(get(@url)).each do |row|
      open_zh_row = Scraper::OpenZhRow.new(row)
      covid_case = open_zh_row.to_covid_case
      covid_case.save!
    rescue StandardError => e
      raise Scraper::LoaderError.new(row, e)
    end
  end

  private

  def get(url)
    Net::HTTP.get(URI(url))
  end

  def read_csv(content)
    CSV.new(content, headers: true)
  end
end
