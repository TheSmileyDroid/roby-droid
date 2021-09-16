# frozen_string_literal: true

require 'discordrb'

# Modulo de utilidades
module Utils
  extend Discordrb::Commands::CommandContainer

  command :help do |_event|
    "
  Ajuda:

   - &help: Essa resposta.
   - Ping!: Responde Pong! e aumenta sua contagem de \"Pong!\"s.
   - Count: Responde a contagem de \"Pong!\"s de todas as pessoas.
  "
  end
end
