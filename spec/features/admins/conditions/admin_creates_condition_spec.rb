require 'rails_helper'

feature 'Admin creates condition' do
  context 'as an admin' do

    before do
      admin = User.create!(name: "Dr.Who", email: "thedoctor@tardis.com", password: "blue", password_confirmation: "blue", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit conditions_path
    end

    context 'when I click on Create Condition' do
      scenario 'it takes me to a new condition form' do
        click_on "Create Condition"

        expect(current_path).to eq(new_admin_condition_path)
        expect(page).to have_content("Create a new condition:")
        expect(page).to have_content("Date:")
        expect(page).to have_content("Max Temperature:")
        expect(page).to have_content("Mean Temperature:")
        expect(page).to have_content("Min Temperature:")
        expect(page).to have_content("Mean Humidity:")
        expect(page).to have_content("Mean Visibility:")
        expect(page).to have_content("Mean Wind Speed:")
        expect(page).to have_content("Precipitation:")
      end
      context 'when I fill in the form and click submit' do
        scenario 'it creates a condition' do
          click_on "Create Condition"

          fill_in :condition_date, with: "Madrid Spain Condition"
          fill_in :condition_dock_count, with: 42
          fill_in :condition_city, with: "Madrid"
          fill_in("Date", :with => "1/1/2013")

          click_on "Submit"

          condition = Condition.last

          expect(current_path).to eq(condition_path(condition))
          expect(page).to have_content("Successfully created a new condition!")
          expect(page).to have_content("Date: #{condition.date.strftime("%m/%d/%Y")}")
          expect(page).to have_content("Max Temperature: #{condition.max_temp}")
          expect(page).to have_content("Mean Temperature: #{condition.mean_temp}")
          expect(page).to have_content("Min Temperature: #{condition.min_temp}")
          expect(page).to have_content("Mean Humidity: #{condition.mean_humidity}")
          expect(page).to have_content("Mean Visibility: #{condition.mean_visibility}")
          expect(page).to have_content("Mean Wind Speed: #{condition.mean_wind_speed}")
          expect(page).to have_content("Precipitation: #{condition.precip}")
        end
      end
    end
  end
  context 'as default user' do
    before do
      user = User.create!(name: "Dalek", email: "dalek@email.com", password: "hack", password_confirmation: "hack", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit new_admin_condition_path
    end
    scenario 'I cannot see the new condition page' do
      expect(page).to_not have_content("Create a new condition:")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
  context 'as visitor' do
    before do
      visit new_admin_condition_path
    end
    scenario 'I cannot see the edit condition page' do
      expect(page).to_not have_content("Create a new condition:")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
