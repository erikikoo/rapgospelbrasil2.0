class HistorysController < ApplicationController
  before_action :set_history, only: [:edit, :update, :destroy]
 
  
  # GET /historys/1
  # GET /historys/1.json
  def show
    @artist_data = ArtistData.find_by(id: params[:id])
  end

  # GET /historys/new
  def new
    @history = History.new
  end

  # GET /historys/1/edit
  def edit
    render :new
  end

  # POST /historys
  # POST /historys.json
  def create
    @history = History.new(history_params)
    @history.artist_data_id = current_artist.id
    respond_to do |format|
      if @history.save
        get_artist_current
        format.js { render '/principal/perfil'}        
      else
        format.js { render :new }        
      end
    end
  end

  # PATCH/PUT /historys/1
  # PATCH/PUT /historys/1.json
  def update
    respond_to do |format|
      if @history.update(history_params)
        @artist_data = ArtistData.find_by('artist_id = ?', current_artist.id)
        @status = 'success'
        @action = 'update'
        format.js { render :show }        
      else
        format.js { render :new }
        
      end
    end
  end

  # DELETE /historys/1
  # DELETE /historys/1.json
  def destroy
    @history.destroy
    respond_to do |format|
      format.html { :new }      
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history
      @history = History.find(params[:id])
      #@artist_data = ArtistData.find_by(id: params[:id])
    end

    def get_artist_current
      @artist_data = ArtistData.find_by(artist_id: current_artist.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def history_params
      params.require(:history).permit(:artist_data_id, :historia)
    end
end
