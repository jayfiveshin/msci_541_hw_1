load 'code/methods.rb'

article = read_gzip("data/chosen_article.txt.gz")
terms = tokenize(article)
tf = calculate_tf(terms)
display_table(tf)
dictionary = build_dictionary(tf)
df = calculate_df(dictionary, "data/latimes_sample.dat.gz")
display_table(df)
