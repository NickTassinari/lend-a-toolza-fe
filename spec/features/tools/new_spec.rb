# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'New Tool Page' do
  before :each do
    @user1 = User.create!(name: 'Test User', email: 'test@example.com', google_id: '123456789', location: '46052')
    stubbed_response = File.read('spec/fixtures/new_tool.json')
    stub_request(:post, "https://lend-a-toolza-be.onrender.com/api/v1/users/#{@user1.id}/tools")
      .to_return(status: 200, body: stubbed_response)

    stub_request(:put, 'https://lend-a-toolza.s3.us-east-2.amazonaws.com/astro.jpeg')
      .to_return(status: 200, body: '', headers: {})

    stubbed_response = File.read('spec/fixtures/users_tools.json')
    stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/users/#{@user1.id}/tools")
      .to_return(status: 200, body: stubbed_response)

    stubbed_response = File.read('spec/fixtures/users_borrowed_tools.json')
    stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/users/#{@user1.id}/tools")
      .to_return(status: 200, body: stubbed_response)
  end

  describe 'As a visitor' do
    it 'Has a form to create a new tool' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit new_tool_path

      expect(current_path).to eq(new_tool_path)
      expect(page).to have_content('Add a New Tool')

      within('#tool_form') do
        expect(page).to have_field('Name')
        expect(page).to have_field('Description')
        expect(page).to have_field('upload_image')
      end
    end

    it 'Can create a new tool' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit new_tool_path

      expect(current_path).to eq(new_tool_path)

      within('#tool_form') do
        fill_in 'Name', with: 'Hammer'
        fill_in 'Description', with: 'A tool to hammer nails'
        attach_file('image', Rails.root.join('spec/images/astro.jpeg'))
        fill_in 'Address', with: '4530 32nd St, San Diego, CA 92116'
      end

      click_button 'Add Tool'
    end

    it "Flashes an error if all fields aren't filled out" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit new_tool_path

      within('#tool_form') do
        fill_in 'Name', with: 'Hammer'

        attach_file('image', Rails.root.join('spec/images/astro.jpeg'))
      end

      click_button 'Add Tool'

      expect(current_path).to eq(new_tool_path)
      expect(page).to have_content('Please fill out all fields')
    end
  end
end
