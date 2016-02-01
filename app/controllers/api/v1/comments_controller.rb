class Api::V1::CommentsController < ApplicationController
  
  authorize_resource      
  respond_to :json
  skip_before_filter :verify_authenticity_token
  before_action :set_comment, only: [:update, :destroy]

  def create 
    @task = Task.find(params[:task_id])
    @task.comments<<Comment.new(comment_params)
    if @task.save
      respond_to do |format|
        format.json{ render :json => @task}
      end
    else respond_with @task
    end
  end

  def update
    if @comment.update(comment_params)
      respond_to do |format|
        format.json{ render :json => @comment}
      end
    else
      respond_with @comment
    end
  end

  def destroy
    respond_with @comment.delete
  end

  private
  
  def comment_params
    if params[:file]
      params['comment']={}
      puts params
      params['comment']['attach']=params[:file]
    end

    params.require(:comment).permit(:text, :attach, :author)      

  end

  def set_comment
     @comment = Comment.find(params[:id])
  end

end
