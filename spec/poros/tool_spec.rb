require "rails_helper"

RSpec.describe Tool do
  it "exists" do
    hammer = Tool.new({
      name: "Hammer",
      description: "A tool",
      image: "https://images-na.ssl-images-amazon.com/images/I/71y%2Bj3zJvXL._AC_SL1500_.jpg",
      location: "Shed",
      status: "available"
    })

    expect(hammer).to be_a(Tool)
    expect(hammer.name).to be_a(String)
    expect(hammer.name).to eq("Hammer")
    expect(hammer.description).to be_a(String)
    expect(hammer.description).to eq("A tool")
    expect(hammer.location).to be_a(String)
    expect(hammer.location).to eq("Shed")
    expect(hammer.status).to be_a(String)
    expect(hammer.status).to eq("available")
    expect(hammer.image).to be_a(String)
    expect(hammer.image).to eq("https://images-na.ssl-images-amazon.com/images/I/71y%2Bj3zJvXL._AC_SL1500_.jpg")
  end
end