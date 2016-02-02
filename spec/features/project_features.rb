feature "Projects", type: :feature, js: true  do
  given(:user) { FactoryGirl.create(:user) }

given!(:project) { FactoryGirl.create(:project, user: user, name: 'test project') }
  
  before do
    login_as user, scope: :user
    visit '/#/'
  end


  scenario 'Add a new project', js: true do
    find('.showCreateProject', visible: false).click
    fill_in 'Project name', with: 'Meow project!'
   find('#time-select').click
   first(".selectable").click
    click_button 'Create project'
    expect(page).to have_content 'Meow project!'
  end
end