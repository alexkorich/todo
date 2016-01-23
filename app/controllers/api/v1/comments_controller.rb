class Api::V1::CommentsController < ApplicationController
  
  authorize_resource      
  respond_to :json
  skip_before_filter :verify_authenticity_token
  before_action :set_comment, only: [:update, :destroy]

  def create 
    @task = Task.find(:task_id)
    @task.comments<<Comment.new(text:params[:text])
    if @task.save
      respond_to do |format|
        format.json{ render :json => @task}
      end
    end
  end

  def update
    @comment.attach=params[:file]
    if @comment.update(comment_params)
      respond_to do |format|
        format.json{ render :json => @comment}
      end
    end
  end

  def destroy
    respond_with @comment.delete
  end

  private
  
  def comment_params

  end

  def set_comment
     @comment = Comment.find(params[:id])
  end

end
