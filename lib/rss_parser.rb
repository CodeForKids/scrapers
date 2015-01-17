require 'rss'
require 'page_creator'

class RSSParser
  def self.parse(url, class_match)
    rss = RSS::Parser.parse(url)
    rss.items.collect { |item| PageCreator.new_from_rss(item, url, class_match) }
  end
end
