# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Show Page', :vcr do
  describe 'As a logged in User' do
    before(:each) do
      @user1 = User.create!(name: 'Test User', email: 'test@example.com', google_id: '123456789', id: 2)
    end

    it 'I can visit my dashboard' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit dashboard_path(@user1.id)

      within '#title' do
        expect(page).to have_content("#{@user1.name}'s Shed")
      end

      within '#tool_box' do
        expect(page).to have_button('Add Tool')
        expect(page).to have_content('My Toolbox')

        within '#tools' do
          expect(page).to have_content('Hammer')
          expect(page).to have_content('Saw')
          expect(page).to have_content('available')
        end
      end

      within '#borrowed_tools' do
        expect(page).to have_content('Screwdriver')
        expect(page).to have_content("Drill")
      end
    end
  end
end
