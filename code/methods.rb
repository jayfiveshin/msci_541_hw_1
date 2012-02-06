require 'zlib'

# accepts name of gzip'd file to be read
# returns text of the file
def gzip_read(file_name)
  Zlib::GzipReader.open(file_name).read
end

def tokenize(string)
  word  = ""
  words = []
  middle_of_tag = false
  string.downcase.split("").each { |char| 
    if char.match(">")
      middle_of_tag = false
    elsif middle_of_tag
      next
    elsif char.match("<")
      middle_of_tag = true
      next
    elsif char.match(/[a-z0-9]/)
      word += char
    elsif word.empty?
      next
    else
      words << word
      word = ""
    end
  }
  words
end
