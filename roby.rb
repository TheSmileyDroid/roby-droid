require 'discordrb'
require 'pg'
require 'sinatra'

puts "Opening database connection ..."
$conn = PG.connect(ENV['DATABASE_URL'])
$conn.exec(<<END_SQL)
  CREATE TABLE IF NOT EXISTS users(
    id_user TEXT NOT NULL,
    count INT DEFAULT 0
  );
END_SQL

$bot = Discordrb::Bot.new token: ENV['BOT_TOKEN']

$bot.message(with_text: 'Ping!') do |event|
  result = $conn.exec_params("
    SELECT count FROM users WHERE id_user = $1::text
    ", [event.author.id])
  puts result
  puts result.inspect
  if result.ntuples > 0
    puts result[0]["count"]
    nResult = result[0]["count"].to_i + 1
    $conn.exec_params("
      UPDATE users
      SET count = $2
      WHERE id_user = $1::text;
    ", [event.author.id, nResult])
  else
    $conn.exec_params("
      INSERT INTO users(id_user)
      VALUES ($1::text);
    ", [event.author.id])
  end
  event.respond 'Pong!'
end

$bot.message(with_text: 'Count') do |event|
  event.respond 'Contagem de "Pongs!": '
  result = $conn.exec("
    SELECT * FROM users;
    ")
    result.to_a.each do |r|
      event.respond "<@%s>: %s"%[r["id_user"], r["count"]]
    end
end


get '/' do
  "I'm alive!"
end
t = Thread.new() {
  $bot.run
}