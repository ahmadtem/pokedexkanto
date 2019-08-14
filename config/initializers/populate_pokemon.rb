Pokemon.connection

count = 1
151.times do
  i = count.to_s
  info = PokeApi.get(pokemon: i)
  species = PokeApi.get(pokemon_species: i)

  @p_name = info.name
  @c_rate = ((species.capture_rate.to_f/256)*100).to_s
  @sprite = info.sprites.front_default
  @shape = species.shape.name
  @types = []
  info.types.to_s.split(',').each do |entry|
    if entry.include? '@name'
      @types.append(entry.split('@name="')[1].chomp('"').capitalize)
    end
  end

  Pokemon.create(name: @p_name, kanto_id: i, capture_rate: @c_rate, types: @types.join(', '), sprite: @sprite, shape: @shape)
  count += 1
end