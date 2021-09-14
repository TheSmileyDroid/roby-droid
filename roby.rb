require 'discordrb'
require 'pg'

bot = Discordrb::Bot.new token: ENV['BOT_TOKEN']

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.run