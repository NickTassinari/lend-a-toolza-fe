class UsersService 

  def self.get_user(id)
    get_url("/api/v1/users/#{id}")
  end

  private 

  def self.conn
    Faraday.new(url: "https://lend-a-toolza-be.onrender.com")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end