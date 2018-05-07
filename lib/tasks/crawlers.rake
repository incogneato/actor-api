require 'rest-client'
require 'nokogiri'
require 'csv'

require_relative '../imdber'

namespace :crawlers do
  desc 'Crawl and save popular actor pages'
  task retrieve_actors_results_pages: :environment do
    (1..1251).step(50) do |with_offset|
      IMDber::Crawler.new.retrieve_actors_results_pages(with_offset)
      sleep 5 + rand(30)
    end
  end

  desc 'Crawl and save best-known work from popular actors'
  task retrieve_best_known_work_pages: :environment do
    IMDber::Crawler.new.retrieve_best_known_work_pages
  end
end
