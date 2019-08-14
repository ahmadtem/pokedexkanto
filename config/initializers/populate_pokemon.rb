Pokemon.connection

PokeApi.get(:type).to_s.split(',').each do |t|
  if t.include? '@name='
    type = t.split('@name="')[1].chomp('"')
    @all_types.append(type)
  end
end

count = 1
151.times do
#3.times do
  i = count.to_s
  info = PokeApi.get(pokemon: i)
  species = PokeApi.get(pokemon_species: i)

  @p_name = info.name
  @c_rate = species.capture_rate          # TO DO: capture rate needs to be percentage
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