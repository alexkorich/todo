class Api::V1::ProjectsController < ApplicationController

  authorize_resource
  before_action :set_project, only: [:update, :destroy] 
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def index
    @projects=Project.where(user:current_user)
    render json: @projects,
    :include => {:tasks => {:include => :comments}}  
  end

  def create 
    @project=Project.new(project_params)
    current_user.projects<<@project
    if @project.save
      render :json => @project
      else
      render json: @project.errors, status: 422
    end
  end

  def update
    if @project.update(project_params)
      respond_to do |format|
        format.json{ render :json => @project}
      end
      else
      render json: @project
    end
  end

  def destroy
    respond_with @project.delete
  end


  private
  
  def project_params
    params.require(:project).permit(:name, :deadline)      
  end

  def set_project
    @project=Project.find(params[:id])  
  end

end
