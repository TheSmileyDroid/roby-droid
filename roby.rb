# frozen_string_literal: true

require 'discordrb'
require 'sinatra'
require_relative 'database'
require_relative 'containers/ping'
require_relative 'containers/utils'
require_relative 'containers/images'

bot = Discordrb::Commands::CommandBot.new token: ENV['BOT_TOKEN'], prefix: '&', intents: [:server_messages]

bot.include! Ping
bot.include! Utils
bot.include! Images

get '/' do
  "I'm alive!"
end
Thread.new do
  bot.run
end
