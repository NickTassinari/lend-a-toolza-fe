class ToolsController < ApplicationController
  def new
  end

  def create

    Aws.config.update(access_key_id: ENV['AWS_ACCESS_KEY'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
    bucket = Aws::S3::Resource.new.bucket(ENV['BUCKET_NAME'])
    file = bucket.object(params[:file].original_filename)
    file.upload_file(params[:file], acl: 'public-read')

    redirect_to root_path
  end
  
  def index
    keyword = params[:name]
    location = params[:location]
    @search_results = ToolFacade.search_tools_by_keyword(keyword, location)
  end

  def show
    @tool = ToolFacade.get_tools_by_id(params[:id])
  end
end