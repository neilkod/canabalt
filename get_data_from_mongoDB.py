""" this is not complete code. It uses create_connection() (elsewhere) to create a mongoDB connection. From there, it queries for tweets that contain canabalt scores. The search is pretty weakly-written but it gets the job done.
From there, it iterates through the resultset and outputs  comma-separated data.
"""
def canabalt_tweets():
	canabalt_regexp = re.compile(r'I ran (\d{3,7})m before (.*) on my ([^.]+)\.')
	tweets = create_connection(False)
	regexp = re.compile('^I ran.*canabalt')
	cur = tweets.conftweets.find({'text': regexp}, {'text': 1})#.limit(10)
	itr = 0
	for item in cur:
		try:
			(score,death,device) = canabalt_regexp.search(item['text']).groups()
			print ','.join([strip_text(score),strip_text(death),strip_text(device)])
			itr += 1
		except:
			pass
	print itr
