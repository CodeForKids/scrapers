require 'uri'
require 'nokogiri'

class PageCreator

  def self.new_from_rss(rss_item, source)
    { title:    rss_item.title,
      content:  rss_item.content_encoded || rss_item.description,
      pub_date: rss_item.pubDate,
      url:      rss_item.link,
      category: pull_category_from_rss_item(rss_item),
      author:   rss_item.author || rss_item.dc_creator,
      image:    page.pull_image_from_content,
      source:   source }
  end

  def self.new_from_cfk_wiki(cfk_hash, category, source)
    { title:    cfk_hash["title"],
      content:  cfk_hash["content"],
      pub_date: cfk_hash["updated_at"],
      url:      rcfk_hash["url"][0..-6],
      category: category,
      author:   cfk_hash["most_common_committer"]["username"],
      image:    page.pull_image_from_content('.inner-content'),
      source:   source }
  end

  def pull_image_from_content(class_match=nil)
    image = Nokogiri::HTML(self.content).search('img').first || Nokogiri::HTML(open(self.url)).search("#{class_match} img").first
    image_url = image['src'] if image
    clean_url(image_url)
  end

  private

  def clean_url(url)
    unless url && url.start_with?("http")
      uri = URI.parse(self.url)
      url = "#{uri.scheme}://#{uri.host}#{url}"
    end
    url
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
