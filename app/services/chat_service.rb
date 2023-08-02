class ChatService
  def self.chat_request(project)
    response = conn.get("/api/v1/chat_request")
    JSON.parse(response.body, symbolize_names: true)
  end


  private

  def self.conn
    Faraday.new(url: "https://lend-a-toolza-be.onrender.com" )
  end
end