# What is this?

An example of how to use my creepin gem.

## How do I make it run

		git clone https://github.com/jasonayre/creepin_example.git
		bundle install
		rake db:drop && rake db:create && rake db:migrate
		rails c
		creeper = AmazonProductCollectionCreeper.new({"field-keywords" => "nixon 51-30 watch"})
		creeper.crawl
