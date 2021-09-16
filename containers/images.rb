# frozen_string_literal: true

require 'discordrb'

# Modulo de utilidades
module Images
  extend Discordrb::Commands::CommandContainer

  command :tucano do |event|
    event.attach_file(File.open('./assets/tucano.jpeg', 'r'))
    'Vai tomar no cu demoro?'
  end
end
