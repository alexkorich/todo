RSpec.describe Api::V1::TasksController, type: :controller do
  include Devise::TestHelpers
  before do
    @user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in @user

    @abilities = Ability.new(@user)
    allow(Ability).to receive(:new).and_return(@abilities)
    @abilities.can :manage, :all
  end

  let!(:project) { FactoryGirl.create(:project, user: @user) }

  describe 'POST #create' do
    let(:task) { attributes_for(:task, project: project) }
    context 'cancan authorizes create' do
      before do
        @abilities.cannot :create, Task
        post :create, format: :json,  project_id: project, task:{name: 'Task1', deadline: DateTime.now}
      end

      it { expect(response).to be_forbidden }
    end

    describe 'with valid attributes' do
      it 'creates a task' do
        expect { post :create, format: :json,  project_id: project, task:{name: 'Task2', done:false, deadline: DateTime.now}}.
          to change(Task, :count).by(1)
      end
    end

    describe 'with invalid attributes' do
      it 'doesnt create a project' do
        expect { post :create, format: :json, project_id: project, task:'' }.
          to_not change(Project, :count)
      end

      it 'returns an error 422' do
        post :create, format: :json, project_id: project, task:''
        expect(response.status).to eq 422
      end
    end
  end

  describe 'PATCH #update' do
    let!(:task) { FactoryGirl.create(:task, project: project) } 
    let(:task_update) { FactoryGirl.attributes_for(:task, project: project) }

    context 'cancan authorizes update' do
      before do
        @abilities.cannot :update, Task
        patch :update, format: :json, id:task, project_id: project, task:{name:task_update[:name]}
      end

      it { expect(response).to be_forbidden }
    end

    describe 'with valid attributes' do
      it 'doesnt change a tasks count' do
        expect { patch :update, format: :json, id:task,  project_id: project,
          task:{name: task_update[:name] }}.to_not change(Task, :count)
      end

      it 'updates task' do
        patch :update, format: :json, id: task,  task:{name: task_update[:name] }
        expect(task.reload.name).to eq task_update[:name]
      end
    end

    describe 'with invalid attributes' do
      it 'doesnt update a project' do
        patch :update, format: :json, id: task, name: ''
        expect(task.reload.name).not_to be_empty
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:task) { FactoryGirl.create(:task )}

    context 'cancan authorizes destroy' do
      before do
        @abilities.cannot :destroy, Task
        delete :destroy, format: :json, id: task
        end
      it { expect(response).to be_forbidden }
    end

    it 'deletes a tasks' do
      expect{ delete :destroy, format: :json, id: task }.
        to change(Task, :count).by(-1)
    end
  end
end
