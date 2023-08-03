class ChatApiService 
  def self.chat_request(project)
    response = conn.get("/api/v1/chat_request", { project: project})
    JSON.parse(response.body)["tools"]
  end

  private 

  def self.conn 
    # Faraday.new(url: "http://localhost:3000")
    Faraday.new(url: "https://lend-a-toolza-be.onrender.com" )
  end

end