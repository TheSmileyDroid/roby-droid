# frozen_string_literal: true

require 'discordrb'
require 'pg'
require 'sinatra'

puts 'Opening database connection ...'
conn = PG.connect(ENV['DATABASE_URL'])
conn.exec(<<END_SQL)
  CREATE TABLE IF NOT EXISTS users(
    id_user TEXT NOT NULL,
    count INT DEFAULT 0
  );
END_SQL

bot = Discordrb::Bot.new token: ENV['BOT_TOKEN']

bot.message(with_text: 'Ping!') do |event|
  result = conn.exec_params("
    SELECT count FROM users WHERE id_user = $1::text
    ", [event.author.id])
  puts result
  puts result.inspect
  if result.ntuples.positive?
    puts result[0]['count']
    n_result = result[0]['count'].to_i + 1
    conn.exec_params("
      UPDATE users
      SET count = $2
      WHERE id_user = $1::text;
    ", [event.author.id, n_result])
  else
    conn.exec_params("
      INSERT INTO users(id_user)
      VALUES ($1::text);
    ", [event.author.id])
  end
  event.respond 'Pong!'
end

bot.message(with_text: 'Count') do |event|
  final_str = "Contagem de \"Pongs!\": \n"
  result = conn.exec("
    SELECT * FROM users;
    ")
  result.to_a.each do |r|
    user = bot.users[r['id_user'].to_i]
    final_str += "#{user.username}: #{r['count']}\n" if user
  end
  puts final_str
  event.respond final_str
end

get '/' do
  "I'm alive!"
end
Thread.new do
  bot.run
end
