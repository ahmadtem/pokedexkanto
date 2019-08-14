json.extract! pokemon, :id, :kanto_id, :name, :types, :shape, :capture_rate, :sprite, :created_at, :updated_at
json.url pokemon_url(pokemon, format: :json)
