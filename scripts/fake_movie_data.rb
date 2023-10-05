require "faker"
require "json"

# Set a random seed for consistent results (optional)
Faker::Config.random = Random.new(42)

# A method to generate a fake movie hash
def fake_movie()
  {
    title: Faker::Movie.title,
    director: Faker::Name.name,
    genre: Faker::Book.genre,
    release_year: Faker::Number.between(from: 1900, to: 2023),
    plot: Faker::Movie.quote,
    actors: (1..3).map { Faker::Name.name },
  }
end

if ARGV.length != 1
  puts "Usage: ruby fake_movie_data.rb number"
  exit(1)
end

begin
  # Convert argument input to integer number
  number = Integer(ARGV[0])

  # Generate an array of fake movie hashes
  fake_data_array = (1..number).map { fake_movie }

  # Convert the array to JSON
  json_data = JSON.pretty_generate(fake_data_array)

  # Define the file name
  file_name = "movies.json"

  # Define the file path to the desktop
  desktop_path = File.expand_path("~/Desktop")

  # Define path to the file
  file_path = File.join(desktop_path, file_name)

  # Write the JSON data to a file on the desktop
  File.open(file_path, "w") do |file|
    file.write(json_data)
  end

  puts "JSON data has been saved to #{file_path}"
rescue
  puts "Argument needs to be an integer number"
end
