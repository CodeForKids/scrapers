require "code_for_kids_wiki"
require "rss_parser"

module Scrapers::Pages
  def self.code_for_kids_wiki_pages
    puts "Fetching Code For Kids Wiki"
    categories = CodeForKidsWiki.categories
    categories.collect { |category| CodeForKidsWiki.pages(category) }.flatten
  end

  def self.kids_code_jeunesse_blog
    puts "Fetching KidsCodeJeunesse blog"
    RSSParser.parse("http://kidscodejeunesse.org/blog/feed/", ".entry-content")
  end

  def self.maker_kids_blog
    puts "Fetching Maker Kids blog"
    RSSParser.parse("https://medium.com/feed/@makerkids", ".section-content")
  end

  def self.tynker_blog
    puts "Fetching Tynker blog"
    RSSParser.parse("http://www.tynker.com/blog/feed/", ".one-post")
  end

  def self.code_org_blog
    puts "Fetching Code.org blog"
    RSSParser.parse("http://codeorg.tumblr.com/rss", "#content")
  end

  def self.scratch_team_blog
    puts "Fetching Scratch Team blog"
    RSSParser.parse("http://blog.scratch.mit.edu/feeds/posts/default?alt=rss", ".post-body")
  end

  def self.code_club_uk_blog
    puts "Fetching Code Club UK blog"
    RSSParser.parse("http://blog.codeclub.org.uk/feed/", ".entry-content")
  end

  def self.kodable_blog
    puts "Fetching Kodable blog"
    RSSParser.parse("http://blog.kodable.com/feed/", ".post")
  end

  def self.hopscotch_blog
    puts "Fetching Hopscotch blog"
    RSSParser.parse("http://blog.gethopscotch.com/rss", ".content")
  end

  def self.help_kids_code_blog
    puts "Fetching Help Kids Code blog"
    RSSParser.parse("https://www.helpkidscode.com/feed/", ".entry-content")
  end
end
