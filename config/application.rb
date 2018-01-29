require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LapemCfe
  class Application < Rails::Application
    config.i18n.available_locales = [:es, :en]
    config.i18n.default_locale = :es

    config.time_zone = 'Pacific Time (US & Canada)'
    config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'languages', '**', '*.{rb,yml}').to_s]

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end
