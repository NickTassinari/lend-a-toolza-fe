class ToolService

  def user_tools(user_id)
    get_url("/api/v1/users/#{user_id}/tools")
  end

  def user_b_tools(user_id)
    get_url("/api/v1/users/#{user_id}/tools/borrowed")
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