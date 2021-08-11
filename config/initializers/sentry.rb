if Rails.env.production?
  Sentry.init do |config|
    config.dsn = 'https://2d442b0d104546cf9c8c452872d7d269@o33120.ingest.sentry.io/5902281'

    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production.
    config.traces_sample_rate = 0.5
    # or
    config.traces_sampler = lambda do |context|
      true
    end
  end
end
