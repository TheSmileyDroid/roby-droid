require 'discordrb'
require 'pg'
require 'sinatra'



#conn = PG::Connection.open(:dbname => 'test')

@bot = Discordrb::Bot.new token: ENV['BOT_TOKEN']


@bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

@bot.message(with_text: 'Count') do |event|
  event.respond 'Contagem de "Pongs!": '
end


get '/' do
  "I'm alive!"
end
t = Thread.new() {
  @bot.run
}