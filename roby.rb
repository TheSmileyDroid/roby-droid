require 'discordrb'
require 'pg'

bot = Discordrb::Bot.new token: 'ODg3MDc1NjgxMjQ5NDA2OTg2.YT-3mw.bwASEeUWeAagOuf4PrWNR5G0snk'

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.run