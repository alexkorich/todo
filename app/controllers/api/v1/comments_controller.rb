module  Api
  module V1
    class CommentsController < ApplicationController
      skip_before_filter :verify_authenticity_token
      respond_to :json
      def index
        puts "aaa"
        puts 
        respond_with Project.all
      end
      def show 
        respond_with(Project.find(params[:id]))
      end
      def create 
        @todo=Project.new(todo_params)
        if @todo.save
          respond_to do |format|
            format.json{ render :json => @todo}
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
 