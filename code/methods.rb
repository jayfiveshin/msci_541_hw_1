require 'zlib'

def gzip_read(file_name)
  Zlib::GzipReader.open(file_name).read
end

def tokenize(doc)
  #do nothing for now
  puts "you tokenized it!"
end
