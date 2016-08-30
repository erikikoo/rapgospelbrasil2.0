class AdminController < ApplicationController
  before_action :get_model_user  
  before_action :get_admin
  before_action :get_dados_artista, only: [:show_artista, :remove_artista, :aprova_artista,:bloquear_artista, :desbloquear_artista]
  before_action :get_aguardando_aprovado
  before_action :get_bloqueado, only: [:index, :artistas,:aprova_artista,:bloquear_artista,:desbloquear_artista, :artistas_filter]
  before_action :get_notice_for_id, only: [:edit_noticia, :remove_noticia, :show_noticia]
  before_action :get_word_for_id, only: [:edit_palavra, :remove_palavra, :show_palavra]
  before_action :get_all_notices, only: [:index,:remove_noticia, :success_noticia,:artistas_filter] 
  before_action :get_all_words, only: [:index, :remove_palavra, :palavras]
  before_action :get_all_artist, only: [:index,:artistas,:remove_artista,:aprova_artista, :bloquear_artista,:desbloquear_artista]
  before_action :get_bloqueado, only: [:index, :artistas_filter]


  before_action :authenticate_artist!

  

  def index  	
    @users = Artist.where(admin: false)
    @artist = ArtistData.where.not(artist_id: @adm.id)        
    
    @aguardando_cadastro = ArtistData.where(nome: nil).where.not(artist_id: @adm.id).includes(:artist)    
    @top5 = Top5.last 

    authorize @users
  end

  def artistas 
  @admin = Artist.where(admin: true).select('id') 	
  end

  def show_artista 
    @videos = Video.where('artist_data_id = ?', params[:id]) 
    
  end

  def artistas_filter    
    @admin = Artist.where(admin: true).select('id')
    
    @query = params[:option]    
    if @query.nil?
      @query = params[:filtro][:option]          
    end
    case @query    
      when 't'
        @artists = ArtistData.where.not(artist_id: @adm.id) 
      when 'a'
        @option = "aprovado"
        @artists = ArtistData.where(aprovado: true, bloqueado: false)
      when 'b'
        @artists = ArtistData.where(bloqueado: true)        
        @option = "bloqueado"
      when 'ap'
        @artists = ArtistData.where.not(aprovado: true, nome: nil)
        @option = "aguardando aprovação"
      when 'i'
         @artists = ArtistData.where(nome: nil).where.not(artist_id: @adm.id).order(created_at: :desc)    
         @option = "com cadastro incompleto" 
    end    
    @profile = 'admin'
    respond_to do |format|    
      format.js
    end
  end

  def remove_artista
    @artist_data = ArtistData.find(params[:id])
    @artist_data.destroy
    render :artistas  
  end

  def aprova_artista
    @artist_data.update_attribute(:aprovado, true)        
    render :artistas
    @profile = 'admin'     
  end

  def bloquear_artista
    @artist_data.update_attribute(:bloqueado, true)        
    render :artistas     
  end

  def desbloquear_artista
    @artist_data.update_attribute(:bloqueado, false)        
    render :artistas     
  end

  def top5
    redirect_to top5s_path
  end



  def videos    
    @videos = Video.where.not(artist_id: nil).select('link')
    @teste = "/admin"
  end

  def novo_video
    @video = Video.new    
    
    @user = '/admin'
  end


  private

    def get_all_notices
       @notices = Notice.all 
    end

    def get_all_artist
      @artists = ArtistData.where.not(artist_id: @adm.id, nome: NIL)
    end

    def get_all_words
      @words = Word.order(created_at: :desc)
    end

    def get_dados_artista
      @artist_data = ArtistData.find(params[:id])
    end

    def get_notice_for_id
      @notice = Notice.find(params[:id])
    end

    def get_word_for_id
      @word = Word.find(params[:id])
    end

    def get_model_user
       @profile = params[:profile] 
    end

    def get_aguardando_aprovado
      @aguandado_aprovacao = ArtistData.where.not(aprovado: true, nome: nil)
    end
    
    def get_bloqueado
      @bloqueado = ArtistData.where(bloqueado: true)
    end

    def get_admin
      @adm = Artist.find_by(admin: true)
    end
end


