load 'code/methods.rb'

article = gzip_read("data/chosen_article.txt.gz")
words = tokenize(article)
tf = calculate_tf(words)
display_tf_table(tf)
