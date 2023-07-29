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
end