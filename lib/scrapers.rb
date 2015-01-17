require "scrapers/version"
require "scrapers/pages"

module Scrapers
  def self.pages
    [ Scrapers::Pages.code_for_kids_wiki_pages,
      Scrapers::Pages.kids_code_jeunesse_blog,
      Scrapers::Pages.maker_kids_blog,
      Scrapers::Pages.tynker_blog,
      Scrapers::Pages.code_org_blog,
      Scrapers::Pages.scratch_team_blog,
      Scrapers::Pages.code_club_uk_blog,
      Scrapers::Pages.kodable_blog,
      Scrapers::Pages.hopscotch_blog,
      Scrapers::Pages.help_kids_code_blog ].flatten
  end
end
