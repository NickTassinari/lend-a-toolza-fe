class ToolsController < ApplicationController

  def new
  end

  def create
    if params_check(params)
      Aws.config.update(access_key_id: ENV['AWS_ACCESS_KEY'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
      bucket = Aws::S3::Resource.new.bucket(ENV['BUCKET_NAME'])
      file = bucket.object(params[:image].original_filename)
      file.upload_file(params[:image], acl: 'public-read')

      attributes = {
        name: params[:name],
        status: params[:status],
        description: params[:description],
        user_id: current_user.id,
        image: file.public_url,
        address: params[:address]
      }
      response = ToolsService.post_tool(attributes, current_user.id)
      redirect_to dashboard_path
    else
      redirect_to new_tool_path
      flash[:error] = "Please fill out all fields"
    end
  end

  def index
    keyword = params[:name]
    location = params[:location]
    @search_results = ToolFacade.search_tools_by_keyword(keyword, location)
  end

  def show
    @tool_id = params[:id]
    @tool = ToolFacade.get_tools_by_id(params[:id])
  end

  def update
    # require 'pry'; binding.pry
    if params[:status] == "borrowed"
      ToolsService.update_tool(current_user.id, params[:id], params[:status], current_user.id)
    else
      ToolsService.update_tool(current_user.id, params[:id], params[:status], nil)
    end
    redirect_to tool_path(params[:id])
  end
  # button_to "Borrow This Tool", tool_path(@tool_id), method: :patch, params: { status: "Borrowed" }

  private

  def params_check(params)
    params[:name].present? && params[:description].present? && params[:image].present? && params[:status].present? && params[:address].present?
  end
end