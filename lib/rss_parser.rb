require 'rss'
require 'page_creator'

class RSSParser
  def self.parse(url)
    rss = RSS::Parser.parse(url)
    rss.items.collect { |item| Page.new_from_rss(item, url) }
  end
end
