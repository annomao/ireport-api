class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    "Welcome to iReport!." 
  end

  #reports routes
  get "/reports/:id" do
    reports = Report.all.where(["user_id= ?", params[:id]]).order(:updated_at)
    reports.to_json
  end

  post "/reports" do
      report = Report.create(
      title:params[:title],
      location:params[:location],
      comment:params[:comment],
      user_id:params[:user_id],
      type_id:params[:type_id]
    )
    report.to_json
  end

  patch "/reports/location/:id" do
    report = Report.find(params[:id])
    report.update(
      location:params[:comment]
    )
    report.to_json
  end

  patch "/reports/comment/:id" do
    report = Report.find(params[:id])
    report.update(
      comment:params[:comment]
    )
    report.to_json
  end

  delete "/reports/:id" do
    report = Report.find(params[:id])
    report.destroy
    report.to_json
  end

end
