class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  configure do
    enable :sessions
    set :session_secret, "session_encryption"
  end

  #check if session Id is stored
  helpers do
    def logged_in? 
      !!session[:user_id]
    end
  end
  
  # User routes
  post "/signup" do
    user = User.find_by(email:params[:email])

    if user == nil
      new_user = User.create(
        name:params[:name],
        username:params[:username],
        email:params[:email],
        password:params[:password]
      )
      new_user.to_json
    else
      status 409
      { errors: "User already exist" }.to_json
    end
  end

  post "/login" do
    user = User.find_by(email:params[:email])
  
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      user.to_json
    else
      status 403
      { errors: "User does not exist" }.to_json
    end
  end

  patch "/users/:id" do
    user = User.find(params[:id])
    user.update(
      name:params[:name],
      username:params[:username]
    )
    user.to_json
  end

  get '/logout' do
    session.clear
  end

  #reports routes

  get "/reports" do
    reports = Report.all.limit(10)
    reports.to_json
  end

  get "/user/reports" do
    if logged_in?
      reports = Report.all.where(["user_id= ?", session[:user_id]]).order(:updated_at)
      reports.to_json
    else
      { errors: "Kindly Login or Create an account" }.to_json
    end
    
  end

  post "/reports" do
    if logged_in?
      report = Report.create(
      title:params[:title],
      location:params[:location],
      comment:params[:comment],
      user_id:session[:user_id],
      type_id:params[:type_id]
    )
    report.to_json
    else
      { errors: "Kindly Login or Create an account" }.to_json
    end
  end

  patch "/reports/:id" do
    if logged_in?
      report = Report.find(params[:id])
      report.update(
        location:params[:location],
        comment:params[:comment]
      )
      report.to_json
    else
      { errors: "Kindly Login or Create an account" }.to_json
    end
  end

  delete "/reports/:id" do
    report = Report.find(params[:id])
    report.destroy
    report.to_json
  end

  #type routes
  get "/types" do
    types = Type.all
    types.to_json
  end

end
