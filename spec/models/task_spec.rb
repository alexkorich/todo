require 'rails_helper'

RSpec.describe Task, type: :model do
  it {should validate_presence_of(:deadline)}
  it {should validate_presence_of(:project)}
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:done)}
  
  
end
