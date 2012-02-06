require 'zlib'
require 'tokenizer'

# accepts name of gzip'd file to be read
# returns text of the file
def gzip_read(file_name)
  Zlib::GzipReader.open(file_name).read
end
