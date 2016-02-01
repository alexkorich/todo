RSpec.describe Api::V1::ProjectsController, type: :controller do
  include Devise::TestHelpers
  before do
    @user = FactoryGirl.create(:user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in @user

    @abilities = Ability.new(@user)
    allow(Ability).to receive(:new).and_return(@abilities)
    @abilities.can :manage, :all

  end
  describe 'GET #index' do
    let!(:projects) { FactoryGirl.create_list(:project, 5, user: @user) }

    context 'cancan authorizes index' do
      before do
        @abilities.cannot :read, Project
        get :index
      end

      it { expect(response).to be_forbidden }
    end

    it 'should return successful response' do
      get :index, format: :json
      expect(response).to be_success
    end

    it 'assigns all projects as @projects' do
      get :index, format: :json
      expect(assigns(:projects)).to match_array projects
    end
  end

  describe 'POST #create' do
    context 'cancan authorizes create' do
      before do
        @abilities.cannot :create, Project
        post :create, format: :json, text: 'New project'
      end

      it { expect(response).to be_forbidden }
    end

    describe 'with valid attributes' do
      it 'creates a comment' do
        expect { post :create, format: :json, project: {name:'New project', deadline:DateTime.now} }.
          to change(Project, :count).by(1)
      end
    end

    describe 'with invalid attributes' do
      it 'doesnt create a project' do
        expect { post :create, format: :json, project: {name:'New project'} }.
          to_not change(Project, :count)
      end

      it 'returns an error 422' do
        post :create, format: :json, title: ''
        expect(response.status).to eq 422
      end
    end
  end

  describe 'PATCH #update' do
    let!(:project) { FactoryGirl.create(:project, user: @user) } 
    let(:project_update) { FactoryGirl.attributes_for(:project, user: @user) }

    context 'cancan authorizes update' do
      before do
        @abilities.cannot :update, Project
        patch :update, format: :json, id: project, title: project_update[:title]
      end

      it { expect(response).to be_forbidden }
    end

    describe 'with valid attributes' do
      it 'doesnt change a projects count' do
        expect { patch :update, format: :json, id: project.id,
          project: {name:'New project'} }.to_not change(Project, :count)
      end

      it 'updates a project' do
        patch :update, format: :json, id: project, project: {name: project_update[:name]}
        expect(project.reload.name).to eq project_update[:name]
      end
    end

    describe 'with invalid attributes' do
      it 'doesnt update a project' do
        patch :update, format: :json, id: project, project:{name:''}
        expect(project.reload.name).not_to be_empty
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:project) { FactoryGirl.create(:project, user: @user) }

    context 'cancan authorizes destroy' do
      before do
        @abilities.cannot :destroy, Project
        delete :destroy, format: :json, id: project
      end

      it { expect(response).to be_forbidden }
    end

    it 'deletes a project' do
      expect{ delete :destroy, format: :json, id: project.id }.
        to change(Project, :count).by(-1)
    end
  end
end
