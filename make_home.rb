require 'slim'

class Link
	attr_accessor :name, :url, :updateUrl

	def initialize(name, url, upd=nil)
		@name = name
		@url = url
		@updateUrl = upd   #########
	end
end

class Group
	attr_accessor :name, :links

	def initialize(name)
		@name = name
		@links = []
	end

	def <<(link)
		@links << link
	end
end

class Scope
	attr_accessor :title, :groups

	def initialize(title, groups)
		@title = title
		@groups = groups
	end
end

title = "pol home"
groups = []

g = Group.new("News")
g << Link.new("Hacker News", "http://news.ycombinator.com")
g << Link.new("Mozilla Blog", "http://blog.mozilla.org/")
groups << g

g = Group.new("Social")
g << Link.new("Gmail", "http://gmail.com")
g << Link.new("Facebook", "http://facebook.com")
g << Link.new("Youtube", "http://youtube.com")
groups << g

# Make .slim file
s = Scope.new(title, groups)
f = File.open('./temp.slim', 'w')
t = Slim::Template.new('./template.slim')
f.write(t.render(s))
f.close

# Make .html file
`slimrb ./temp.slim > ./home.html`
`rm -f ./temp.slim`

