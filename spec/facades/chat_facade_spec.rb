require 'rails_helper'
require "./app/facades/chat_facade"

RSpec.describe ChatFacade do
  it "exists and returns chat text" do 
    
    chat_prompt = File.read('spec/fixtures/chat_response.json')
    stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/chat_request")
    .to_return(status: 200, body: chat_prompt, headers: {'Content-Type': 'application/json' })
    
    project = "deck"
    
    chat = ChatFacade.chat_request(project)
    expect(chat).to be_a(String)
    
  end
end
