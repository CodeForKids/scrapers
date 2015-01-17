require 'net/http'
require 'uri'
require 'nokogiri'

class PageCreator

  def self.new_from_rss(rss_item, source, class_match)
    content = rss_item.content_encoded || rss_item.description
    { title:    rss_item.title,
      content:  content,
      pub_date: rss_item.pubDate,
      url:      rss_item.link,
      category: pull_category_from_rss_item(rss_item),
      author:   rss_item.author || rss_item.dc_creator,
      image:    pull_image_from_content(content, rss_item.link, class_match),
      source:   source }
  end

  def self.new_from_cfk_wiki(cfk_hash, category, source)
    { title:    cfk_hash["title"],
      content:  cfk_hash["content"],
      pub_date: cfk_hash["updated_at"],
      url:      cfk_hash["url"][0..-6],
      category: category,
      author:   cfk_hash["most_common_committer"]["username"],
      image:    pull_image_from_content(cfk_hash["content"], cfk_hash["url"][0..-6], '.page-content'),
      source:   source }
  end

  def self.pull_image_from_content(content, url, class_match=nil)
    image = Nokogiri::HTML(content).search('img').first || Nokogiri::HTML(open(url)).search("#{class_match} img").first
    image_url = image['src'] if image
    clean_url(image_url)
  end

  private

  def self.clean_url(url)
    uri = URI.parse(url) if url
    url = "#{uri.scheme}://#{uri.host}#{url}" if url && !url.start_with?("http")
    url = nil if url && url_404s?(url)
    url
  end

  def self.url_404s?(url)
    begin
      url = URI.parse(url)
      req = Net::HTTP.new(url.host, url.port)
      res = req.request_head(url.path)
      res.code == "404"
    rescue
      true
    end
  end

  def self.pull_category_from_rss_item(rss_item)
    categories =  rss_item.categories.collect do |category|
                    category.respond_to?(:content) ?
                    category.content :
                    category
                  end
    categories.join(", ") || "Uncategorized"
  end

end
