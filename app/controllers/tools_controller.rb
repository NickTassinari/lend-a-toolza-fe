# frozen_string_literal: true

class ToolsController < ApplicationController
  def new; end

  def create
    attributes = {
      name: params[:name],
      status: params[:status],
      description: params[:description],
      user_id: current_user.id,
      address: params[:address]
    }
    ToolsService.post_tool(attributes, current_user.id)
    if status == 200 && params_check(params)
      Aws.config.update(access_key_id: ENV['AWS_ACCESS_KEY'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
      bucket = Aws::S3::Resource.new.bucket(ENV['BUCKET_NAME'])
      file = bucket.object(params[:image].original_filename)
      file.upload_file(params[:image], acl: 'public-read')
      redirect_to dashboard_path(current_user.id)
    else
      redirect_to new_tool_path
      flash[:error] = 'Please fill out all fields'
    end
  end

  def index
    keyword = params[:tool]
    location = params[:location]
    params[:radius]
    @search_results = ToolFacade.search_tools_by_keyword(keyword, location)
  end

  def show
    @tool = ToolFacade.get_tools_by_id(params[:id])
  end

  private

  def params_check(params)
    params[:name].present? && params[:description].present? && params[:image].present? && params[:status].present? && params[:address].present?
  end
end
