## Actor-API Docs
#### Running Rails 5.2, Ruby 2.5.1

This is a simple project that:

1. retrieves short bios for all actors on IMDb born on a specific day, saves the respective html pages,
2. then retrieves and saves the respective html for each actors' "most known work"
3. next, it parses the html pages into CSV files,
4. then it seeds the data into a mySQL db, and lastly,
5. has the machinery to make said data available via API.

The data model is basic: an `Actor has_one MostKnownWork` and vice-versa.

### Organization details

1. crawlers/scrapers (originally written purely as scripts) moved into rake tasks,
  - organized by function:
    - lib/tasks/crawlers.rake
    - lib/tasks/scrapers.rake
  - meant to be used by objective:
    - lib/tasks/seed_actors.rake    
    - lib/tasks/seed_actors.rake
  - all this functionality accessible as part of one call to `rake db:seed` (and of course individually).
    - seed this code in db/seeds.rb

2. "ETL" process goes as follows:
- retrieving and saving html files (crawling)
- parsing the html into CSV files (scraping)
- ingesting clean CSV files into database
    - CSVs will be written to respective lib/imdb/ folders

3. Interesting logic lives in lib/imdber.rb (where crawling / scraping concerns are again kept 'together' but otherwise organized by function), eg:
- `IMDber::Crawler#retrieve_actors_results_pages`
- `IMDber::Crawler#retrieve_best_known_work_pages`
- `IMDber::Scraper#parse_actors_results_pages`
- `IMDber::Scraper#parse_known_work_pages`

**Side Note:**

To simplify the task of seeding of the data, there is a duplicated column - both `actors` and `most_known_works` have a column for their respective known-work url.

I'm temporarily using this as the effective foreign key, again, only to make life easier while seeding the initial data (1200+ rows per table in my example), because the alternative was a "%fuzzy search%" on the film name, which was far less reliable. This column should be removed after the data is seeded, before deploy.

### Visuals:

<dl>
  <dt>Actors endpoint:<dt>
  <p>Paginated actors results sorted by their respective most-known works' ratings)</p>
  <dd><a href="https://screencast.com/t/4RX2Zf5Iwp" target="_blank">GET /api/v1/actors/</a><dd>

  <dt>Birth-date search endpoint:</dt>
  <dd><a href="https://screencast.com/t/od5fhtsL" target="_blank">GET /api/v1/actors/search/:birth_month/:birth_day</a><dd>

  <dt>Screenshot of actual data (local):</dt>
  <dd><a href="https://screencast.com/t/HU9so4DaQa" target="_blank">Respective SQL "search" query</a><dd>
</dl>
