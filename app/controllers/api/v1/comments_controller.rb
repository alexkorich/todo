class Api::V1::CommentsController < ApplicationController
      
  skip_before_filter :verify_authenticity_token
  respond_to :json

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
  # def find_comment
  #    @project = Project.where("tasks._id" => BSON::ObjectId(params[:taskId])).first
  #   task=@project.tasks.find(params[:taskId])
  #   comment = task.comments.find(params[:id])
  # end
end
