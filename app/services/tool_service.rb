class ToolService

  def self.user_tools(user_id)
    get_url("/api/v1/users/#{user_id}/tools")
  end

  def self.user_b_tools(user_id)
    get_url("/api/v1/users/#{user_id}/tools/borrowed")
  end

  def self.get_tool(tool_id)
    get_url("/api/v1/tools/#{id}")
  end

  def self.get_tools
    get_url("/api/v1/tools")
  end

  private

  def conn
    Faraday.new(url: "https://lend-a-toolza-be.onrender.com")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end