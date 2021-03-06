require 'rails_helper'

RSpec.describe Project, type: :model do
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:deadline)}
  it {should validate_presence_of(:user)}
  it { should have_many(:tasks) }
  

  xit {should validate_uniqueness_of(:name)} #bug in shoulda

  
end
