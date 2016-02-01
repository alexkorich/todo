require 'cancan/matchers'
require 'rails_helper'

RSpec.describe Ability, type: :model do
  describe "abilities of non-logged user" do

    subject { ability }
    let(:user){ nil } 
    let(:ability){ Ability.new(user) }
   
    context 'for projects' do 
      let(:project){ FactoryGirl.create(:project) }

      it { expect(subject).not_to be_able_to(:create, project) }
      it { expect(subject).not_to be_able_to(:read, project) }
      it { expect(subject).not_to be_able_to(:update, project) }
      it { expect(subject).not_to be_able_to(:destroy, project) }
    end

    context 'for tasks' do 
      let(:task){ FactoryGirl.create(:task) }
   
      it { expect(subject).not_to be_able_to(:create, task) }
      it { expect(subject).not_to be_able_to(:read, task) }
      it { expect(subject).not_to be_able_to(:update, task) }
      it { expect(subject).not_to be_able_to(:destroy, task) }
    end

    context 'for comments' do 
       let(:comment){ FactoryGirl.create(:comment) }
   
      it { expect(subject).not_to be_able_to(:create, comment) }
      it { expect(subject).not_to be_able_to(:read, comment) }
      it { expect(subject).not_to be_able_to(:update, comment) }
      it { expect(subject).not_to be_able_to(:destroy, comment) }
    end

  describe "abilities of loggined user" do

    subject { ability }
    let(:user){ FactoryGirl.create(:user) } 
    let(:user2){ FactoryGirl.create(:user) }
    let(:ability){ Ability.new(user) }
   
     context 'for projects' do 
      let(:project){ FactoryGirl.create(:project , user:user) }
      let(:project2){ FactoryGirl.create(:project, user:user2) }

      it { expect(subject).to be_able_to(:create, project) }
      it { expect(subject).to be_able_to(:read, project) }
      it { expect(subject).to be_able_to(:update, project) }
      it { expect(subject).to be_able_to(:destroy, project) }

      it { expect(subject).not_to be_able_to(:read, project2) }
      it { expect(subject).not_to be_able_to(:update, project2) }
      it { expect(subject).not_to be_able_to(:destroy, project2) }
    end

    context 'for tasks' do 
      let(:project){ FactoryGirl.create(:project , user:user) }
      let(:task){ FactoryGirl.create(:task, project: project) }
      let(:task2){ FactoryGirl.create(:task) }
   
      it { expect(subject).to be_able_to(:create, task) }
      it { expect(subject).to be_able_to(:read, task ) }
      it { expect(subject).to be_able_to(:update, task ) }
      it { expect(subject).to be_able_to(:destroy, task) }

      it { expect(subject).not_to be_able_to(:create, task2) }  # some others task
      it { expect(subject).not_to be_able_to(:read, task2) }
      it { expect(subject).not_to be_able_to(:update, task2) }
      it { expect(subject).not_to be_able_to(:destroy, task2) }

    end

    context 'for comments' do 
      let(:project){ FactoryGirl.create(:project , user:user) }
      let(:task){ FactoryGirl.create(:task, project: project) }
      let(:comment){ FactoryGirl.create(:comment, task: task) }
      let(:comment2){ FactoryGirl.create(:comment) }
   
      it { expect(subject).to be_able_to(:create, comment) }
      it { expect(subject).to be_able_to(:read, comment) }
      it { expect(subject).to be_able_to(:update, comment) }
      it { expect(subject).to be_able_to(:destroy, comment) }

      it { expect(subject).not_to be_able_to(:create, comment2) }
      it { expect(subject).not_to be_able_to(:read, comment2) }
      it { expect(subject).not_to be_able_to(:update, comment2) }
      it { expect(subject).not_to be_able_to(:destroy, comment2) }
    end
  end
end
 
end
