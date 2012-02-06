load 'code/methods.rb'

article = gzip_read("data/chosen_article.txt.gz")
terms = tokenize(article)
tf = calculate_tf(terms)
display_tf_table(tf)
