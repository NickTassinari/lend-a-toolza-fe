class ToolsService

  def self.user_tools(user_id)
    response = conn.get("/api/v1/users/#{user_id}/tools")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.user_b_tools(user_id)
    response = conn.get("/api/v1/users/#{user_id}/tools/borrowed")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.search_tools_by_keyword(keyword, location)
    response = conn.get("/api/v1/search?name=#{keyword}&location=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_tools_by_id(id)
    JSON.parse(conn.get("/api/v1/tools/#{id}").body, symbolize_names: true)
  end

  def self.get_tools
    response = conn.get("/api/v1/tools")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.post_tool(attributes, user_id)
    response = conn.post do |r|
      r.url "/api/v1/users/#{user_id}/tools"
      r.headers['Content-Type'] = 'application/json'
      r.body = attributes.to_json
    end
    JSON.parse(response.body, symbolize_names: true)
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