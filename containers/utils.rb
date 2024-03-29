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
   - &tucano: Envia a imagem do 'Vai tomar no cu demorou?'
   - &image <Imagem> <Indice da imagem>: Envia uma imagem do site Unsplash.
  "
  end
end
