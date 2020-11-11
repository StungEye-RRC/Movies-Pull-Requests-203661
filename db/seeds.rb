require "csv"

MovieGenre.delete_all
Genre.delete_all
Movie.delete_all
ProductionCompany.delete_all
Page.delete_all

Page.create(
  title:     "About the Data",
  content:   "The data powering this website was provided by a Kaggle dataset about the IMDB movie ratings.",
  permalink: "about_the_data"
)

Page.create(
  title:     "Contact Us",
  content:   "If you want to chat about movies email me at wally.glutton@mailinator.com.",
  permalink: "contact_us"
)

filename = Rails.root.join("db/top_movies.csv")

puts "Loading Movies from the CSV file: #{filename}"

csv_data = File.read(filename)
movies = CSV.parse(csv_data, headers: true, encoding: "utf-8")

movies.each do |m|
  production_company = ProductionCompany.find_or_create_by(name: m["production_company"])

  if production_company&.valid?
    movie = production_company.movies.create(
      title:        m["original_title"],
      year:         m["year"],
      duration:     m["duration"],
      description:  m["description"],
      average_vote: m["avg_vote"]
    )

    unless movie&.valid?
      puts "Invalid movie #{m['original_title']}"
      next
    end

    genres = m["genre"].split(",").map(&:strip)
    genres.each do |genre_name|
      genre = Genre.find_or_create_by(name: genre_name)
      MovieGenre.create(movie: movie, genre: genre)
    end

  else
    puts "Invalid production company #{m['production_company']} for movie #{m['original_title']}."
  end
end

puts "Created #{ProductionCompany.count} Production Companies"
puts "Created #{Movie.count} Movies"
puts "Created #{Genre.count} Genres"
puts "Created #{MovieGenre.count} Movie Genres"
