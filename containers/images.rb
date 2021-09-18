# frozen_string_literal: true

require 'discordrb'
require 'unsplash'

Unsplash.configure do |config|
  config.application_access_key = '6SKyH-4wKFUVcSzaaTce8C4AWlz8iXu9_CRTEhYLZ-s'
  config.application_secret = 'U4NeWVTJLsstHBo7Y1qCQa_OdHnIoHdiLQJriO1oGyw'
  config.application_redirect_uri = 'https://your-application.com/oauth/callback'
  config.utm_source = 'roby-droid'
end

# Modulo de utilidades
module Images
  extend Discordrb::Commands::CommandContainer

  command :tucano do |event|
    event.attach_file(File.open('./assets/tucano.jpeg', 'r'))
    'Vai tomar no cu demoro?'
  end

  command :image do |_event, image, index = 0|
    results = Unsplash::Photo.search(image, per_page: 30)
    results[index.to_i]['urls']['regular']
  end
end
