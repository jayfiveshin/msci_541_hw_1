require 'zlib'

def tokenize(line, tf)
  line.downcase!
  line.split.each { |word|
    unless word.start_with?('<') and word.end_with?('>')
      while !word.match(/[^a-z0-9]/).nil?
        word.slice!(/[^a-z0-9]/)
      end
      if tf[word.to_sym].nil?
        tf[word.to_sym] = 1
      else
        tf[word.to_sym] += 1
      end
    end
  }
end

def tokenize_line(line)
  array = []
  line.downcase!
  line.split.each { |word|
    unless word.start_with?('<') and word.end_with?('>')
      while !word.match(/[^a-z0-9]/).nil?
        word.slice!(/[^a-z0-9]/)
      end
      array << word unless array.include?(word)
    end
  }
  array
end

def sort_hash(hash)
  hash = Hash[hash.sort_by { |word, count| -1*count }]
end

def display_tf_table(sorted_hash)
  rank = 1
  puts "RANK\tWORD\t\tTF"
  sorted_hash.each { |word, count|
    if rank > 40
      break
    end
    if word.length > 7
      puts rank.to_s + "\t" + word.to_s + "\t" + count.to_s
    else
      puts rank.to_s + "\t" + word.to_s + "\t\t" + count.to_s
    end
    rank = rank + 1
  }
end

Zlib::GzipReader.open('chosen_article.txt.gz') { |document|
  @tf = {} #term frequency

  document.each { |line| 
    tokenize(line, @tf)
  }
  @tf = sort_hash(@tf)
}

display_tf_table(@tf)

Zlib::GzipReader.open('latimes.dat.gz') { |document| 
  df = {} #document frequency
  dict = @tf.keys
  temp_array = []
  line_count = 1
  doc_count = 1
  document.each { |line|
    if line.include?("<DOC>")
      break if doc_count > 1
      temp_array = []
      doc_count += 1
    elsif line.include?("</DOC>")
      # incomplete
      puts "#{line_count} lines processed"
      puts "temporary array is the following:"
      puts temp_array
    else
      temp_array << tokenize_line(line)
      print "."
      line_count += 1
    end
  }
}

#some comments here
