Bugsnag.configure do |config|
  config.api_key = ENV['IGNAZ_BUGSNAG_API_KEY']
  config.notify_release_stages = %w[production]
end
