require 'rest-client'
require 'nokogiri'
require 'csv'

require_relative '../imdber'

namespace :scrapers do
  desc 'Scrape actor pages'
  task parse_actors_results_pages: :environment do
    IMDber::Scraper.new.parse_actors_results_pages
  end

  desc 'Scrape best-known work pages from popular actors'
  task parse_known_work_pages: :environment do
    IMDber::Scraper.new.parse_known_work_pages
  end
end
