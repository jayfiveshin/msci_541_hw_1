require 'zlib'

# accepts name of gzip'd file to be read
# returns text of the file
def gzip_read(file_name)
  Zlib::GzipReader.open(file_name).read
end

def tokenize(string)
  term  = ""
  terms = []
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
      term += char
    elsif term.empty?
      next
    else
      terms << term
      term = ""
    end
  }
  terms
end

def calculate_tf(terms)
  tf = {}
  terms.each { |term|
    if tf[term].nil?
      tf[term] = 1
    else
      tf[term] += 1
    end
  }
  tf
end

def sort_by_frequency(tf_hash)
  Hash[tf_hash.sort_by { |term, frequency| -1*frequency}]
end

def display_tf_table(tf_hash)
  rank = 1
  puts "RANK\tTERM\t\tFREQUENCY"
  sort_by_frequency(tf_hash).each { |term, frequency|
    if rank > 20
      break
    end
    if term.length > 7
      puts "#{rank}\t#{term}\t#{frequency}"
    else
      puts "#{rank}\t#{term}\t\t#{frequency}"
    end
    rank += 1
  }
end
