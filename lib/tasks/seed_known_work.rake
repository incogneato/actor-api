namespace :seed_most_known_work do
  desc 'Invoke crawler and scraper to collect and parse known work pages'
  task invoke_most_known_work_crawler_and_scrapers: :environment do
    Rake::Task['crawlers:retrieve_best_known_work_pages'].invoke
    Rake::Task['scrapers:parse_known_work_pages'].invoke
  end
end
