class CreatePokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemons do |t|
      t.integer :kanto_id
      t.string :name
      t.string :types
      t.string :shape
      t.integer :capture_rate
      t.string :sprite

      t.timestamps
    end
  end
end
