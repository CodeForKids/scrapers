require 'httparty'
require 'page_creator'

class CodeForKidsWiki
  CFK_WIKI_URL = "https://wiki.codeforkids.ca"

  def self.categories
    HTTParty.get("#{CFK_WIKI_URL}/categories.json").parsed_response.collect do |category_hash|
      CodeForKidsWiki::Category.new(category_hash)
    end
  end

  def self.pages(category)
    per_page = 50
    pages = category.number_of_pages / per_page + 1
    category_pages = []

    pages.times do |page|
      url = "#{CFK_WIKI_URL}/category/#{category.handle}.json?per_page=#{per_page}&page=#{page + 1}"
      HTTParty.get(url).parsed_response["pages"].each do |page_hash|
        category_pages << PageCreator.new_from_cfk_wiki(page_hash, category.name, CFK_WIKI_URL)
      end
    end

    category_pages
  end
end

class CodeForKidsWiki::Category
  attr_accessor :id, :name, :handle, :url, :updated_at, :number_of_pages

  def initialize(hash)
    self.id = hash["id"]
    self.name = hash["name"]
    self.handle = hash["handle"]
    self.url = hash["url"]
    self.updated_at = hash["updated_at"]
    self.number_of_pages = hash["number_of_pages"]
  end
end
