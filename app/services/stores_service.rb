# frozen_string_literal: true

class StoresService
  def self.get_stores(location, radius)
    response = conn.get("/api/v1/stores/#{location}/#{radius}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://lend-a-toolza-be.onrender.com')
    # Faraday.new(url: "http://localhost:3000")
  end
end
