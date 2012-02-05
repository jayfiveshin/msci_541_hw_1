require 'zlib'

# outputs file
def gzip_read(filename)
  Zlib::GzipReader.open(filename).read
end
