require 'csv'

Rake::Task['seed_actors:invoke_actors_crawler_and_scrapers'].invoke
Rake::Task['seed_most_known_work:invoke_most_known_work_crawler_and_scrapers'].invoke

CSV.foreach('lib/imdb/actors-films.csv') do |row|
  actor = Actor.create!(
    name: row[0],
    photo_url: row[1],
    profile_url: "https://www.imdb.com" + "#{row[2]}",
    film: row[3],
    birth_day: 02,
    birth_month: 02
  )

  actor.create_most_known_work!(
    url: "https://www.imdb.com" + "#{row[3]}",
    title: row[4]
  )
end


CSV.foreach('lib/imdb/actors/known-work/known-work-fields.csv') do |row|
  if title = MostKnownWork.find_by(url: row[3])
    title.update!(
      rating: row[1],
      director: row[2]
    )
  end
end
