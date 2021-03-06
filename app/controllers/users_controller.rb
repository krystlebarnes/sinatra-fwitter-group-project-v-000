class UsersController < ApplicationController

  get "/signup" do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect "/tweets"
    end
  end

  post "/signup" do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to "/signup"
    else
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
      user.save
      session[:user_id] = user.id
      redirect to "/tweets"
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get "/login" do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/users/login'
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end


end
