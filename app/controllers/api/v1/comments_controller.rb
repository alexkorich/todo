module  Api
  module V1
    class CommentsController < ApplicationController
      skip_before_filter :verify_authenticity_token
      respond_to :json
      def index
        respond_with Project.find(params[:project_id]).comments
      end
      def show 
        respond_with Project.find(params[:project_id]).comments
      end
      def create 

          @project = Project.where("tasks._id" => BSON::ObjectId(params[:id])).first
        task=@project.tasks.find(params[:id])
        task.comments<<Comment.new(text:params[:text])
        if @project.save
          respond_to do |format|
            format.json{ render :json => @project}
          end
        end
      end
      def update
        @todo = Project.find(params[:id])
        if @todo.update(todo_params)
          respond_to do |format|
            format.json{ render :json => @todo}
          end
        end
      end
      def destroy
          respond_with Project.destroy(params[:id])
      end
    end
  end
end
 