class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
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
      user_data = {
          id: user.id,
          name: user.name,
          username: user.username,
          email: user.email
        }
      user_data.to_json
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

  #reports routes

  get "/reports" do
    reports = Report.all.limit(10)
    reports.to_json
  end

  get "/user/reports/:id" do
      reports = Report.all.where(["user_id= ?", params[:id]]).order(:updated_at)
      reports.to_json
    
  end

  post "/reports" do
    report = Report.create(
      title:params[:title],
      location:params[:location],
      comment:params[:comment],
      status: "Pending",
      user_id:params[:user],
      type_id:params[:type_id]
     )
    report.to_json
  end

  patch "/reports/:id" do
    report = Report.find(params[:id])
    report.update(
        location:params[:location],
        comment:params[:comment]
      )
    report.to_json
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
