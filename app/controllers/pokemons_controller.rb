class PokemonsController < ApplicationController
  #  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]

  # GET /pokemons
  # GET /pokemons.json
  def index
    if params[:types].present?
      t = '%'+ params[:types] +'%'
      @pokemons = Pokemon.where('types LIKE ?', t).order("id ASC")
    else
      @pokemons = Pokemon.search(params[:search]).order("id ASC")
    end

    respond_to do |format|
      format.html
      format.csv { send_data @pokemons.to_csv , :disposition => "attachment; filename=pokemon.csv"}
      format.xml { send_data JSON.parse(@pokemons.to_json).to_xml , :disposition => "attachment; filename=pokemon.xml"}
      format.json { send_data @pokemons.to_json , :disposition => "attachment; filename=pokemon.json"}

    end
  end

  # GET /pokemons/1
  # GET /pokemons/1.json
  def show
    set_pokemon
  end

  # GET /pokemons/new
  def new
    @pokemon = Pokemon.new
  end

  # GET /pokemons/1/edit
  def edit
    set_pokemon
  end

  # POST /pokemons
  # POST /pokemons.json
  def create
    @pokemon = Pokemon.new(pokemon_params)

    respond_to do |format|
      if @pokemon.save
        format.html { redirect_to @pokemon, notice: 'Pokemon was successfully created.' }
        format.json { render :show, status: :created, location: @pokemon }
      else
        format.html { render :new }
        format.json { render json: @pokemon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pokemons/1
  # PATCH/PUT /pokemons/1.json
  def update
    set_pokemon
    respond_to do |format|
      if @pokemon.update(pokemon_params)
        format.html { redirect_to @pokemon, notice: 'Pokemon was successfully updated.' }
        format.json { render :show, status: :ok, location: @pokemon }
      else
        format.html { render :edit }
        format.json { render json: @pokemon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pokemons/1
  # DELETE /pokemons/1.json
  def destroy
    set_pokemon
    @pokemon.destroy
    respond_to do |format|
      format.html { redirect_to pokemons_url, notice: 'Pokemon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pokemon_params
    params.require(:pokemon).permit(:kanto_id, :name, :types, :shape, :capture_rate, :sprite, :search)
  end

end
