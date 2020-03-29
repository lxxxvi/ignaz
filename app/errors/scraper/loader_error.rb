class Scraper::LoaderError < StandardError
  def initialize(row, error)
    msg = "Row: #{row.inspect}\n\n#{error}\n#{error.backtrace.join("\n")}"

    super msg
  end
end
