module IMDber
  class Crawler
    BASE_URL = 'https://www.imdb.com'
    AGENT = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36'

    def retrieve_actors_results_pages(with_offset)
      url = BASE_URL
      url += '/search/name?birth_monthday=02-02'
      url += "&start=#{with_offset}"

      response = RestClient.get(url, {'User-Agent' => AGENT})
      page = Nokogiri::HTML(response)
      save_html(page, "#{Rails.root}/lib/imdb/actors", "start-#{with_offset}")
    end

    def retrieve_best_known_work_pages
      CSV.foreach("#{Rails.root}/lib/imdb/actors-films.csv") do |row|
        if row[3]
          actor_name = slugify(row[0])
          film_name = slugify(row[4])
          url = BASE_URL + "#{row[3]}"
          response = RestClient.get(url, {'User-Agent' => AGENT})
          page = Nokogiri::HTML(response)
          save_html(page, "#{Rails.root}/lib/imdb/actors/known-work", "#{actor_name}-#{film_name}")
          sleep 5 + rand(30)
        end
      end
    end

    def save_html(page, path, file_name)
      File.open("#{path}/#{file_name}.html", 'w+') do |file|
        file.write(page)
      end
    end

    def slugify(value)
      value.gsub!(/[^\x00-\x7F]/n, '').to_s
      value.gsub!(/[']+/, '')
      value.gsub!(/\W+/, ' ')
      value.strip!
      value.downcase!
      value.gsub!(' ', '-')
      value
    end
  end

  class Scraper
    def parse_actors_results_pages
      CSV.open("#{Rails.root}/lib/imdb/actors-films.csv", 'wb') do |writer|
        actor_results_pages = Dir.glob("#{Rails.root}/lib/imdb/actors/*.html")
        actor_results_pages.each do |page|
          doc = Nokogiri::HTML(File.open(page))
          actors = doc.css('.lister-item')
          actors.each do |actor|
            actor_name    = actor.at_css('.lister-item-content a').text.strip rescue nil
            photo_url     = actor.at_css('.lister-item-image img')[:src]
            profile_url   = actor.at_css('.lister-item-header a')[:href]
            film_endpoint = actor.at_css('.text-muted.text-small a')[:href] rescue nil
            film_name     = actor.at_css('.text-muted.text-small a').text.strip rescue nil

            writer << [actor_name, photo_url, profile_url, film_endpoint, film_name]
          end
        end
      end
    end

    def parse_known_work_pages
      CSV.open("#{Rails.root}/lib/imdb/actors/known-work/known-work-fields.csv", 'wb') do |writer|
        known_work_pages = Dir.glob("#{Rails.root}/lib/imdb/actors/known-work/*.html")
        known_work_pages.each do |page|
          doc = Nokogiri::HTML(File.open(page))
          rating        = doc.at_css('.ratingValue span').children.first.text.strip  rescue 'blank'
          director_name = doc.at_css('.credit_summary_item a span').text.strip rescue 'blank'
          film_name     = doc.at_css('.title_wrapper h1').text.strip
          page_url      = doc.at_css('#quicklinksMainSection a')['href'].split('fullcredits')[0]

          row = [film_name, rating, director_name, page_url]
          writer << row
        end
      end
    end
  end
end
