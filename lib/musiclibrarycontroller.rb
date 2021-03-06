class MusicLibraryController
  attr_accessor :path

  def initialize(path = './db/mp3s')
    @path = path
    importer = MusicImporter.new(@path)
    importer.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    input = ''
    until input == 'exit' do
      input = gets.downcase.strip

    case input
    when  "list songs"
      list_songs
    when "list artists"
      list_artists
    when "list genres"
      list_genres
    when "list artist"
      list_songs_by_artist
    when "list genre"
      list_songs_by_genre
    when "play song"
       play_song
    end
 end
end

    def list_songs
      #binding.pry
      Song.all.sort_by {|song| song.name}.each_with_index {|v, i| puts "#{i + 1}. #{v.artist.name} - #{v.name} - #{v.genre.name}"}
    end

    def list_artists
      Artist.all.sort_by {|artist| artist.name}.each_with_index {|a, i| puts "#{i + 1}. #{a.name}"}
    end

    def list_genres
      Genre.all.sort_by {|genre| genre.name}.each_with_index {|g, i| puts "#{i + 1}. #{g.name}"}
    end

    def list_songs_by_artist
      puts "Please enter the name of an artist:"
      input = gets.chomp
      #binding.pry
      a = Artist.find_by_name(input)
      if a
        a.songs.sort_by {|s| s.name}.each_with_index {|s, i| puts "#{i + 1}. #{s.name} - #{s.genre.name}"}
      end
    end

    def list_songs_by_genre
      puts "Please enter the name of a genre:"
      input = gets.chomp
      g = Genre.find_by_name(input)
      if g
        g.songs.sort_by {|s| s.name}.each_with_index {|s, i| puts "#{i + 1}. #{s.artist.name} - #{s.name}"}
      end
    end

    def play_song
      puts "Which song number would you like to play?"
      input = gets.strip
      index = input.to_i - 1
      songs = Song.all.sort_by {|song| song.name}
      if index <= songs.size and index >= 0
      puts "Playing #{songs[index].name} by #{songs[index].artist.name}" if songs[index]
      end
    end


end
