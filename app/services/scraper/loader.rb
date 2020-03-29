class Scraper::Loader < Scraper
  def initialize(url)
    @url = url
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
      puts "*** ERROR"
      puts "#{row.inspect}"
      puts ""
      puts "#{e}"
      puts "#{e.backtrace.join("\n")}"
      puts ""
      puts ""
    end
  end
end
