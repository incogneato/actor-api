json.key_format! camelize: :lower
json.people @actors do |actor|
  json.(actor, :name, :photo_url, :profile_url)

  json.most_known_work do
    json.title actor.most_known_work.title
    json.url actor.most_known_work.url
    json.rating actor.most_known_work.rating
    json.director actor.most_known_work.director
  end
end
