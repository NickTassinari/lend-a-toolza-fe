class ToolsService 

  def self.search_tools_by_keyword(keyword, location)
    response = conn.get("/api/v1/search?name=#{keyword}&location=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_tools 
    JSON.parse(conn.get("/api/v1/tools").body, symbolize_names: true)
  end

  def self.get_tools_by_id(id)
    JSON.parse(conn.get("/api/v1/tools/#{id}").body, symbolize_names: true)
  end


  private 

  def self.conn 
    Faraday.new(url: "https://lend-a-toolza-be.onrender.com" )
  end

  # def get_url(url)
  #   response = conn.get(url)
  #   JSON.parse(response.body, symbolize_names: true)
  # end
end