require 'rails_helper'

RSpec.describe ToolsService do 
  it 'returns a list of tools' do 
    VCR.use_cassette('tools_service_get_tools') do 

      tools = ToolsService.get_tools
      require 'pry'; binding.pry
      expect(tools).to be_a Hash
    end
  end
end