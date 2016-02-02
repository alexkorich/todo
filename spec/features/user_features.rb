require "features/features_test_helper"

describe "signup" do
  # before :each do
  #   FactoryGirl.create :user, email:'user@example.com', password: 'password', password_confirmation: 'password'
  # end
let (:user) {FactoryGirl.build :user}

feature "login/logup", js: true do

  scenario "Visitor registers successfully via register form" do
      visit '/'

        click_button 'Sign up'
        fill_in 'Username', with: "John"
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Password', with: 'password'
      click_button 'Register'
      expect(page).to have_content 'Add TODO'
    end
  end


end