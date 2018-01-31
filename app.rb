require "cuba"
require "cuba/safe"
require "cuba/render"
require "erb"
require "sqlite3"

Cuba.use Rack::Session::Cookie, :secret => ENV["SESSION_SECRET"] || "__a_very_long_string__"

Cuba.plugin Cuba::Safe
Cuba.plugin Cuba::Render

db = SQLite3::Database.new "./db/dev.db"

Cuba.define do
  on root do
    student_array = db.execute("SELECT * FROM bands")
    bands = student_array.map do |id, name, year, myrank|
      { :id => id, :name => name, :firstalbumyear => year, :myrank => myrank }
    end
    res.write view("index", bands: bands)
  end

  on "new" do
    res.write view("new")
  end

  on post do
    on "create" do
      p req.params
      name = req.params["name"]
      firstalbumyear = req.params["year"]
      myrank = req.params["rank"]
      db.execute(
        "INSERT INTO bands (name, firstalbumyear, myrank) VALUES (?, ?, ?)",
        name, firstalbumyear, myrank
      )
      res.redirect "/"
    end

    on "delete/:id" do |id|
      db.execute(
        "DELETE FROM bands WHERE id=#{id}"
      )
      res.redirect "/"
    end
  end

  def not_found
    res.status = "404"
    res.headers["Content-Type"] = "text/html"

    res.write view("404")
  end
end
