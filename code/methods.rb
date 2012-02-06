require 'zlib'

# accepts name of gzip'd file to be read
# returns text of the file
def read_gzip(file_name)
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

def calculate_df(dictionary, file_name)
  df = {}
  doc = ""
  doc_count = 0
  middle_of_doc = false
  Zlib::GzipReader.open(file_name) { |string|
    string.each { |line|
      line.downcase!
      if line.match("</doc>")
        doc << line
        dictionary.each { |term|
          if doc.match(term)
            if df[term].nil?
              df[term] = 1
            else
              df[term] += 1
            end
          end
        }
        middle_of_doc = false
        doc = ""
        next
      elsif middle_of_doc
        doc << line
        next
      elsif line.match("<doc>")
        doc_count += 1
        puts doc_count
        doc << line
        middle_of_doc = true
        next
      end
    }
  }
  df
end

def build_dictionary(tf_hash)
  dictionary = tf_hash.keys
end

def sort_by_frequency(tf_hash)
  Hash[tf_hash.sort_by { |term, frequency| -1*frequency}]
end

def display_table(tf_hash)
  rank = 1
  puts "RANK\tTERM\t\tFREQUENCY"
  sort_by_frequency(tf_hash).each { |term, frequency|
    # if rank > 20
    #   break
    # end
    if term.length > 7
      puts "#{rank}\t#{term}\t#{frequency}"
    else
      puts "#{rank}\t#{term}\t\t#{frequency}"
    end
    rank += 1
  }
end
