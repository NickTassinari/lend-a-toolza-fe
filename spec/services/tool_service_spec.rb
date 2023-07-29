require "rails_helper"

RSpec.describe ToolService do
  let!(:user_tools) { ToolService.new.user_tools(1) }

  it "establishes a connection for a users tools" do
    expect(user_tools).to be_a(Hash)
    expect(user_tools).to have_key(:data)
    expect(user_tools[:data]).to be_an(Array)
    expect(user_tools[:data][0]).to have_key(:id)
    expect(user_tools[:data][0][:id]).to be_a(String)
    expect(user_tools[:data][0]).to have_key(:attributes)
    expect(user_tools[:data][0][:attributes]).to be_a(Hash)
    expect(user_tools[:data][0][:attributes]).to have_key(:name)
    expect(user_tools[:data][0][:attributes][:name]).to be_a(String)
    expect(user_tools[:data][0][:attributes]).to have_key(:description)
    expect(user_tools[:data][0][:attributes][:description]).to be_a(String)
    expect(user_tools[:data][0][:attributes]).to have_key(:image)
    expect(user_tools[:data][0][:attributes][:image]).to be_a(String)
    expect(user_tools[:data][0][:attributes]).to have_key(:status)
    expect(user_tools[:data][0][:attributes][:status]).to be_a(String)
    expect(user_tools[:data][0][:attributes]).to have_key(:location)
    expect(user_tools[:data][0][:attributes][:location]).to be_a(String)
  end
end