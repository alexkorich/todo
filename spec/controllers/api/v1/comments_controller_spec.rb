RSpec.describe Api::V1::CommentsController, type: :controller do
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
  let!(:task){FactoryGirl.create(:task, project: project)}
 

  describe 'POST #create' do
    # let(:comment) { FactoryGirl.attributes_for(:comment, project: project) }

    context 'cancan authorizes create' do
      before do
        @abilities.cannot :create, Comment
        post :create, task_id: task, format: :json, text: 'New comment'
      end
      it { expect(response).to be_forbidden }
    end

    describe 'with valid attributes' do
      it 'creates a comment' do
        expect { post :create, format: :json, task_id: task,  comment:{text: 'New comment'} }.
          to change(Comment, :count).by(1)
      end
    end

    describe 'with invalid attributes' do
      it 'doesnt create a project' do
        expect { post :create, task_id: task, format: :json, text: '' }.
          to_not change(Comment, :count)
      end

      it 'returns an error 422' do
        post :create, project_id: project, task_id: task, format: :json, comment:{text:""}
        expect(response.status).to eq 422
      end
    end
  end

  describe 'PATCH #update' do
    let!(:comment) { FactoryGirl.create(:comment, task: task) } 
    let(:comment_update) { FactoryGirl.attributes_for(:comment, task:task) }

    context 'cancan authorizes update' do
      before do
        @abilities.cannot :update, Comment
        patch :update, id: comment, format: :json, comment:{text:comment_update[:text]}
      end

      it { expect(response).to be_forbidden }
    end

    describe 'with valid attributes' do
      it 'doesnt change a comment count' do
        expect { patch :update, id: comment,  format: :json, comment:{text:comment_update[:text]} }.to_not change(Comment, :count)
      end

      it 'updates a comment' do
       patch :update, id: comment,  format: :json, comment:{text:comment_update[:text]}
        expect(comment.reload.text).to eq comment_update[:text]
      end
    end

    describe 'with invalid attributes' do
      it 'doesnt update a project' do
        patch :update, id: comment,  format: :json, comment:{text:''}
        expect(comment.reload.text).not_to be_empty
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment) { FactoryGirl.create(:comment, task: task) }

    context 'cancan authorizes destroy' do
      before do
        @abilities.cannot :destroy, Comment
        delete :destroy, format: :json, id: comment
      end

      it { expect(response).to be_forbidden }
    end

    it 'deletes a project' do
      expect{ delete :destroy, format: :json, id: comment }.
        to change(Comment, :count).by(-1)
    end
  end
end
