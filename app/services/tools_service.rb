class ToolsService 

  def self.get_tool(id)
    get_url("/api/v1/tools/#{id}")
  end

  def self.get_tools 
    JSON.parse(conn.get("/api/v1/tools").body, symbolize_names: true)
  end


  private 

  def self.conn 
    Faraday.new(url: "https://lend-a-toolza-be.onrender.com" )
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end