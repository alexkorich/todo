require "features/features_test_helper"

describe "signup" do
  # before :each do
  #   FactoryGirl.create :user, email:'user@example.com', password: 'password', password_confirmation: 'password'
  # end
let (:user) {FactoryGirl.create :user}
feature "login/logup" do

  scenario "Visitor registers successfully via register form" do
      visit '/'
      within '#user-nav' do
        click_link 'Sign up'
      end
      within("#new_user") do
        fill_in 'Name', with: "John"
        fill_in 'Email', with: 'user@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'Password confirmation', with: 'password'
      end
      click_button 'Sign up'
      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end



     scenario "Visitor logins successfully" do
      visit '/'
      user
        within("#new_user") do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
      end
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully'
    end


    scenario "First registered user in the system  becomes a Lunches Admin" do
      visit '/'
      within '#user-nav' do
        click_link 'Sign up'
      end
      within("#new_user") do
        fill_in 'Name', with: "John"
        fill_in 'Email', with: 'user@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'Password confirmation', with: 'password'
      end
      click_button 'Sign up'
      expect(page).to have_link 'Rails admin', href:'/rails_admin/'
      
      click_link 'Logout'
      user
        within("#new_user") do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
      end
      click_button 'Log in'
      expect(page).not_to have_link 'Admin page', href:'/rails_admin/'
    end
  end


end