load 'code/methods.rb'

article = gzip_read("data/chosen_article.txt.gz")
tokenize article
