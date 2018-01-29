require "sqlite3"

db = SQLite3::Database.new "./db/dev.db"

db.execute "
  create table bands (
    id INTEGER PRIMARY KEY ASC,
    name VARCHAR(255),
    first-album-year VARCHAR(255),
    my-rank VARCHAR(255)
  );
"

bands = [
  ["Led Zeppelin", "1968", "1"],
  ["Steely Dan", "1972", "2"],
  ["Pink Floyd", "1967", "3"],
  ["The Beatles", "1963", "4"],
  ["Rush", "1974", "5"],
  ["Creedence Clearwater Revival", "1968", "6"],
  ["Iron Maiden", "1981", "7"]
]

students.each do |band|
  db.execute(
    "INSERT INTO students (name, first-album-year, my-rank) VALUES (?, ?, ?)",
    band
  )
end
