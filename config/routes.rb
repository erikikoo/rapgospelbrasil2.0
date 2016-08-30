
Rails.application.routes.draw do

  resources :likes
  resources :link_sound_clouds
  devise_for :artists
  resources :top5s
  resources :words
  resources :notices
  resources :contacts, only: [:new, :create]
  resources :eventos, only: [:new, :create]
  

  mount Ckeditor::Engine => '/ckeditor'


  
  #pag index artist
  get '/like/:id'                         => 'likes#create'
  get '/like/:id/:status'                 => 'likes#update'
  get '/unlike/:id'                       => 'likes#update'

  #pag show a artist

  get '/showlike/:id/:target'                => 'likes#create'
  get '/like/:id/:status/:target'            => 'likes#update'
  get '/unlike/:id/:target'                  => 'likes#update'


  #index
  get 'index'                         => 'welcome#red_index'
  #pagina principal 
  get 'welcome/index'
  get '/principal'                    => 'principal#index'
  get '/noticias'                     => 'welcome#noticia'
  get '/palavras'                     => 'welcome#palavra'
  get '/artistas'                     => 'welcome#artista' 
  get '/videos'                       => 'welcome#video'
  get '/contato'                      => 'welcome#contato'
  get '/quem_somos'                   => 'welcome#quem_somos'  
  get 'termo_de_uso'                  => 'welcome#termo_de_uso'
  get 'politica'                      => 'welcome#politica'
  get 'termo_de_uso/:target'          => 'welcome#termo_de_uso'
  get '/show_noticia/:id'             => 'notices#show'
  get '/show_palavra/:id'             => 'words#show'  
  get '/show_artista/:id'             => 'artist_datas#show'
  get '/search_artista'               => 'artist_datas#search_artista'
  get '/faq'                          => 'welcome#faq'
  get '/faq_portal'                   => 'welcome#faq_portal'
  get '/faq_artistas'                 => 'welcome#faq_artistas'
  get '/faq_conteudo'                 => 'welcome#faq_conteudo'
  get '/faq_integracao'               => 'welcome#faq_integracao'
  get '/faq_cadastro'                 => 'welcome#faq_cadastro'
  get '/faq_anuncios'                 => 'welcome#faq_anuncios'
  get '/dicas'                        => 'welcome#dicas'
  get '/dicas_cadastro'               => 'welcome#dicas_cadastro'
  get '/dicas_perfil'                 => 'welcome#dicas_perfil'
  get '/dicas_eventos'                => 'welcome#dicas_eventos'
  get '/dicas_email'                  => 'welcome#dicas_email'
  get '/dicas_telefone'               => 'welcome#dicas_telefone'
  get '/dicas_discografia'            => 'welcome#dicas_discografia'
  get '/dicas_redesocial'             => 'welcome#dicas_redesocial'
  get '/dicas_soundcloud'             => 'welcome#dicas_soundcloud'
  get '/dicas_videos'                 => 'welcome#dicas_videos'
  
  #pag contato 
  

  #adm
  get '/top5/:profile'                     => 'admin#top5'
  
  get '/show_artista/:id/:profile'         => 'admin#show_artista'  
  get 'admin/index'
  get '/artistas/:profile'                 => 'admin#artistas'
  get '/artistas_filter'                   => 'admin#artistas_filter'
  get '/artistas_filter/:option'           => 'admin#artistas_filter'
  
  
  get '/palavras/:profile'                 => 'words#index'
  get '/nova_palavra/:profile'             => 'words#new'
  get '/edit_palavra/:id/:profile'         => 'words#edit'
  get '/show_palavra/:id/:profile'         => 'words#show'
  get '/show_soundcloud/:id/:profile'      => 'link_sound_clouds#index'    
  get '/palavras/:profile/:status'         => 'words#update'

  get '/noticias/:profile'                 => 'notices#index'
  get '/nova_noticia/:profile'             => 'notices#new'
  get '/edit_noticia/:id/:profile'         => 'notices#edit'
  get '/show_noticia/:id/:profile'         => 'notices#show'  
  get '/noticias/:profile/:status'         => 'notices#index'

  get '/aprovar_artista/:id/:profile'      => 'admin#aprova_artista'
  get '/bloquear_artista/:id/:profile'     => 'admin#bloquear_artista'
  get '/desbloquear_artista/:id/:profile'  => 'admin#desbloquear_artista'

  get '/videos/:profile'                            => 'admin#videos'
  get '/novo_video/:profile'                        => 'videos#new'
  delete 'remove_artista/:id/:profile'              => 'admin#remove_artista'
  delete 'remove_noticia/:id/:profile'              => 'notices#destroy'
  delete 'remove_palavra/:id/:profile'              => 'words#destroy'
  delete 'remover_sound_cloud/:id/:profile'     => 'link_sound_clouds#destroy'
  delete 'remove_top5/:id'                          => 'top5s#destroy'
  #novo 
  get '/novo_disco/:id'        => 'discographys#new'
  get '/novo_agenda/'          => 'commitments#new'
  get '/novo_email/'           => 'emails#new'
  get '/novo_telefone/'        => 'phones#new'
  get '/novo_video/'           => 'videos#new'
  get '/novo_link_sound_cloud' => 'link_sound_clouds#new'
  get '/novo_rede_social'      => 'rede_sociais#new'

  get '/novo_top5/'            => 'top5s#new' 
  #rotas ajax
  #views padrão (sem login)
  get '/principal/perfil'          => 'principal#perfil'
  get '/album/:id/:profile'        => 'artist_datas#discography'  
  get '/contato/:id'               => 'artist_datas#contact'
  get '/historia/:id'              => 'artist_datas#history'
  get '/agenda/:id/:profile'       => 'artist_datas#agenda'
  get '/videos/:id/:profile'       => 'artist_datas#videos'
  

  #views user


  #apresenta artista existente
  
  get '/show_agenda/:id/:profile'           => 'commitments#index'
  get '/show_disco/:id/:profile'            => 'discographys#index'
  get '/show_historia/:id/:profile'         => 'historys#show'
  get '/new_historia/:id/:profile'          => 'historys#new'
  get '/show_redesocial/:id/:profile'       => 'rede_sociais#index'
  get '/show_email/:id/:profile'            => 'emails#index'
  get '/show_telefone/:id/:profile'         => 'phones#index'
  
  get '/show_video/:id/:profile'            => 'videos#index'  
  
  #edita artista existente
  get '/edit_artista/:id'                         => 'artist_datas#edit'
  get '/edit_agenda/:id/:profile'                 => 'commitments#edit'
  get '/edit_disco/:id/:profile'                  => 'discographys#edit'  
  get '/edit_email/:id/:profile'                  => 'emails#edit'  
  get '/edit_telefone/:id/:profile'               => 'phones#edit'  
  get '/edit_sound_cloud/:id/:profile'            => 'link_sound_clouds#edit'  
  get '/edit_rede_social/:id/:profile'            => 'rede_sociais#edit'
  
  
  #remove items
  delete '/remove_disco/:id/:profile'          => 'discographys#destroy'
  delete '/remove_agenda/:id/:profile'         => 'commitments#destroy'
  delete '/remove_email/:id/:profile'          => 'emails#destroy'
  delete '/remove_telefone/:id/:profile'       => 'phones#destroy'
  delete '/remove_video/:id/:profile'          => 'videos#destroy'
  delete '/remove_rede_social/:id/:profile'    => 'rede_sociais#destroy'


  post '/videos/:user' => 'videos#create'
  
  get '/contato'       => 'contacts#new' 
  #post '/contato'      => 'contacts#create' 

  get '/envie_notice'                 => 'eventos#new'
  #get '/envie_notice'                 => 'events#create'

   resources :discographys
   resources :phones
   resources :emails
   resources :artist_datas
   resources :rede_sociais
   resources :videos
   resources :commitments  
   resources :historys
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


  # You can have the root of your site routed with "root"
   root 'welcome#index'

  # Example of regular route:
     

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
