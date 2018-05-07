namespace :seed_actors do
  desc 'Invoke crawler and scraper to collect and parse actor results pages'
  task invoke_actors_crawler_and_scrapers: :environment do
    Rake::Task['crawlers:retrieve_actors_results_pages'].invoke
    Rake::Task['scrapers:parse_actors_results_pages'].invoke
  end
end
