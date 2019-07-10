class PostsController < Sinatra::Base

    register Sinatra::ActiveRecordExtension

    configure do
        set :views, "app/views"
      set :public_dir, "public"
      #enables sessions as per Sinatra's docs. Session_secret is meant to encript the session id so that users cannot create a fake session_id to hack into your site without logging in. 
      enable :sessions
      set :session_secret, "secret"
    end

    get '/test' do
        "test"
    end

    get '/posts/create_ads' do

        @categ = Category.all

        erb :'/posts/make_post', layout: :my_layout
    end
    
    post '/make' do
        category_id = params[:category]
        ads = Post.create(title:params[:title],body: params[:body],user_id: session[:user_id],category_id: category_id)
        redirect '/users/home'
    end
    
    get '/posts/:id' do
        id = params[:id]
        @post = Post.find_by(id:id)
        @from_time = @post.created_at
        @hour = Post.get_post_time(@from_time)
        if session[:user_id] ==@post.user_id
            @edit=@post.id
        end

        erb :'/posts/post_show', layout: :my_layout
    end

    get '/edit_post/:id' do
        @post = Post.find_by(params[:id])
        @categ = Category.all

        erb :"/posts/edit_post", layout: :my_layout

    end

    put '/edit' do

        category_id = params[:category]
        ads = Post.update(title:params[:title],body: params[:body],user_id: session[:user_id],category_id: category_id)
        redirect '/users/home'

    end
    
    

end


