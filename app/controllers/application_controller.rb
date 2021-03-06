class ApplicationController < Sinatra::Base

  require_relative 'posts_controller'

  use PostsController

  register Sinatra::ActiveRecordExtension

  configure do
  	set :views, "app/views"
    set :public_dir, "public"
    #enables sessions as per Sinatra's docs. Session_secret is meant to encript the session id so that users cannot create a fake session_id to hack into your site without logging in. 
    enable :sessions
    set :session_secret, "secret"
  end

  # Renders the home or index page
  get '/' do

    # hard code
    @catg = []
    id=[]
    categories = Category.all
    categories.each do |category|
      @catg<<category.category_title
      id<<category.id
      # puts "#{category.id}==="

    end
    @catg_id = id.uniq
    @post1 = Post.where(category_id:@catg_id[0])
    @post2 = Post.where(category_id:@catg_id[1])
    @post3 = Post.where(category_id:@catg_id[2])
    @post4 = Post.where(category_id:@catg_id[3])
    @post5 = Post.where(category_id:@catg_id[4])
    erb :home#layout: :my_layout

  end

  # Renders the sign up/registration page in app/views/registrations/signup.erb
  get '/registrations/signup' do

    erb :'/registrations/signup', layout: :my_layout

  end

  # Handles the POST request when user submits the Sign Up form. Get user info from the params hash, creates a new user, signs them in, redirects them. 
  post '/registrations' do
    user = User.create(name:params["name"], email: params["email"])
    user.password = params["password"]
    user.save

    session[:user_id] = user.id
    # byebug
    redirect '/users/home'
    
   
  end
  
  # Renders the view page in app/views/sessions/login.erb
  get '/sessions/login' do
    erb :'/sessions/login'
  end

  # Handles the POST request when user submites the Log In form. Similar to above, but without the new user creation.
  post '/sessions' do
    @posts = Post.all
    @user = User.find_by(email:params["email"])
    if @user.password == params["password"]
      session[:user_id] = @user.id
      redirect '/users/home'
    else
      redirect '/sessions/login'
    end

  end

  # Logs the user out by clearing the sessions hash. 
  get '/sessions/logout' do

    session.clear

    redirect "/"

  end
 
  get '/users/home' do
    @user= User.find(session[:user_id])

    @posts = Post.all
    erb :'/users/home', layout: :my_layout

  end

end