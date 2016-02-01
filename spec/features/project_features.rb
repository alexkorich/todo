RSpec.feature "Projects", type: :feature, js: true  do
  given!(:user) { FactoryGirl.create(:user) }
 
 background do

    visit '/'
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    puts user.password
    click_button 'Log In'
  end

  scenario 'Add a new project', js: true do
    find('.showCreateProject', visible: false).click
    fill_in 'Project name', with: 'Meow project!'
    fill_in "Select deadline", with: '2016-02-11 21:40:00'

    click_button 'Submit'
    expect(page).to have_content 'Meow project!'
  end
end