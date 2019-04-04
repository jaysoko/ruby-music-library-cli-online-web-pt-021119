require 'pry'
class Song
  @@all = []
  attr_accessor :name, :artist, :genre

  def initialize(name,artist=nil,genre=nil)
    @name = name
    self.artist = artist unless artist == nil
    self.genre = genre unless genre == nil
  end

  def artist=(artist)
    @artist = artist unless artist == nil
    artist.add_song(self)
  end

def genre=(genre)
  @genre = genre unless genre == nil
   genre.songs << self unless genre.songs.include?(self)
end

def self.find_by_name(name)
  @@all.find {|x| x.name == name}
end

def self.find_or_create_by_name(name)
  self.find_by_name(name) || self.create(name)
end

def self.new_from_filename(file)
   artist, name, genre = file.split('.mp3').join.split(' - ')
   #song = self.create(name)
   artist = Artist.find_or_create_by_name(artist)
   genre =  Genre.find_or_create_by_name(genre)
   song = Song.new(name, artist, genre)
   #song.genre = genre
   #song
   #binding.pry
   #song = Song.new(path_split[1], artist, genre)
   #song.save
   #binding.pry
end

  def self.create_from_filename(filename)
    song = Song.new_from_filename(filename)
    song.save
    song
  end

def self.all
  @@all
end

def self.destroy_all
  @@all.clear
end

def save
  @@all << self
end

def self.create(name)
  song = Song.new(name)
  song.save
  song
end

end
