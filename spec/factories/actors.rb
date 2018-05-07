FactoryBot.define do
  factory :actor, class: 'Actor' do
    name        "Thor Edgell"
    photo_url   "imageurl.com/asdf.png"
    profile_url "imdb.com/name/nm4449173"
    birth_day   02
    birth_month 02
  end

  factory :most_known_work, class: 'MostKnownWork' do
    actor
    title    "The Elder Scrolls V: Skyrim"
    url      "imdb.com/title/tt3243396"
    director  "Rodd Coward"
    rating    9.6
  end

  factory :actor_without_date, class: 'Actor' do
    name        "Rudolf Krieg"
    photo_url   "imageurl.com/asdf.png"
    profile_url "imdb.com/name/nm4449173"
  end

  factory :most_known_work_for_actor_without_date, class: 'MostKnownWork' do
    actor_without_date
    title    "The Elder Scrolls V: Skyrim"
    url      "imdb.com/title/tt3243396"
    director  "Konrad Wagner"
    rating    9.6
  end
end
