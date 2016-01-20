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
        puts "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
        puts params[:file]
        puts "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"

        @project = Project.where("tasks._id" => BSON::ObjectId(params[:taskId])).first
        task=@project.tasks.find(params[:taskId])
        comment = task.comments.find(params[:id])
        comment.attach=params[:file]
        if @project.update()
          respond_to do |format|
            format.json{ render :json => @project}
          end
        end
      end

      def destroy
        puts params
       @project = Project.where("tasks._id" => BSON::ObjectId(params[:taskId])).first
        task=@project.tasks.find(params[:taskId])
        comment=task.comments.find(params[:id])
          respond_with comment.delete
      end

    end
  end
end
 