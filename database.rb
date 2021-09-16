# frozen_string_literal: true

require 'pg'

puts 'Opening database connection ...'
CONN = PG.connect(ENV['DATABASE_URL'])
CONN.exec(<<END_SQL)
  CREATE TABLE IF NOT EXISTS users(
    id_user TEXT NOT NULL,
    count INT DEFAULT 0
  );
END_SQL
