class ToolFacade
  def self.get_tools
    ToolsService.get_tools[:data].map do |tool|
      Tool.new(tool)
    end
  end

  def self.search_tools_by_keyword(keyword, location)
    ToolsService.search_tools_by_keyword(keyword,location)[:data].map do |tool|
      Tool.new(tool)
    end
  end

  def self.get_tools_by_id(id)
    ToolsService.get_tools_by_id(id)[:attributes]
  end

  def self.users_tools(user_id)
    ToolsService.user_tools(user_id)[:data].map do |tool|
      Tool.new(tool)
    end
  end

  def self.users_b_tools(user_id)
    ToolsService.user_b_tools(user_id)[:data].map do |tool|
      Tool.new(tool)
    end
  end
end