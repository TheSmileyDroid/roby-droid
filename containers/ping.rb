# frozen_string_literal: true

require 'discordrb'
require_relative '../database'

# Modulo com eventos Ping!
module Ping
  extend Discordrb::EventContainer

  message(with_text: 'Ping!') do |event|
    result = CONN.exec_params("
      SELECT count FROM users WHERE id_user = $1::text
      ", [event.author.id])
    puts result
    if result.ntuples.positive?
      puts result[0]['count']
      n_result = result[0]['count'].to_i + 1
      CONN.exec_params("
        UPDATE users
        SET count = $2
        WHERE id_user = $1::text;
      ", [event.author.id, n_result])
    else
      CONN.exec_params("
        INSERT INTO users(id_user)
        VALUES ($1::text);
      ", [event.author.id])
    end
    event.respond 'Pong!'
  end

  message(with_text: 'Count') do |event|
    final_str = "Contagem de \"Pongs!\": \n"
    result = CONN.exec("
      SELECT * FROM users;
      ")
    result.to_a.each do |r|
      user = event.server.member(r['id_user'].to_i) # bot.users[r['id_user'].to_i]
      final_str += "#{user.display_name}: #{r['count']}\n" if user
    end
    puts final_str
    event.respond final_str
  end
end
