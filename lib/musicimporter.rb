class MusicImporter
attr_accessor :path, :files

def initialize(path)
@path = path
@files = Dir.children(@path)
#binding.pry
end

  def import
    @files.each do |file|
      Song.create_from_filename(file)
    end
  end

end
