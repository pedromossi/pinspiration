Rails.application.routes.draw do
  # Routes for the Comment resource:

  # CREATE
  post("/insert_comment", { :controller => "comments", :action => "create" })
          
  # READ
  # get("/comments", { :controller => "comments", :action => "index" })
  
  # get("/comments/:path_id", { :controller => "comments", :action => "show" })
  
  # # UPDATE
  
  # post("/modify_comment/:path_id", { :controller => "comments", :action => "update" })
  
  # # DELETE
  # get("/delete_comment/:path_id", { :controller => "comments", :action => "destroy" })

  #------------------------------

  # Routes for the Pin resource:

  # CREATE
  get("/insert_pin/:photo_id", { :controller => "pins", :action => "create" })
          
  # READ
  get("/pins/:user_id", { :controller => "pins", :action => "index" })

  # get("/pins", { :controller => "pins", :action => "index" })
  
  # get("/pins/:path_id", { :controller => "pins", :action => "show" })
  
  # UPDATE
  
  # post("/modify_pin/:path_id", { :controller => "pins", :action => "update" })
  
  # DELETE
  get("/delete_pin/:photo_id", { :controller => "pins", :action => "destroy" })

  #------------------------------

  # Routes for the Photo resource:

  # CREATE
  post("/insert_photo", { :controller => "photos", :action => "create" })
          
  # READ
  get("/photos", { :controller => "photos", :action => "index" })
  
  get("/photos/:path_id", { :controller => "photos", :action => "show" })
  
  # UPDATE
  
  post("/modify_photo/:path_id", { :controller => "photos", :action => "update" })
  
  # DELETE
  get("/delete_photo/:path_id", { :controller => "photos", :action => "destroy" })



  # USER PHOTOS
  get("/user_photos/:user_id", { :controller => "photos", :action => "user_photos" })

  # NEW PHOTO
  get("/new_photo", { :controller => "photos", :action => "new_photo" })

  #------------------------------

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "photos#index"
end
