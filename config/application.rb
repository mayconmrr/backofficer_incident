# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BackofficerIncident
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.i18n.default_locale = :'pt-BR'
    config.time_zone = 'America/Sao_Paulo'

    config.autoload_paths += %W[#{config.root}/app/]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    Rails.logger = Logger.new(STDOUT)
    Rails.logger.level = Logger::DEBUG
  end
end
