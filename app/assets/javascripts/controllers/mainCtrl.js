angular.module('todoList')
.controller("MainCtrl", [
  '$scope', "Projects","Tasks", "Comments",
   function($scope, Projects, Tasks, Comments, $http){
      $scope.newTask={};
      $scope.test = 'Hello world!';

      $scope.projects=Projects.query();

      $scope.createProject=function(){
        Projects.save();
        $scope.projects=Projects.query()
      };

      $scope.deleteProject=function(id){
        Projects.delete({id:id});
        $scope.projects=Projects.query()
      };

      $scope.createTask=function(id){
        console.log(id);
        Projects.newTask({id:id, task:{name:$scope.newTask.name}});
        $scope.projects=Projects.query()
      };
       $scope.deleteTask=function(id){
        console.log(id);
        Tasks.delete({id:id});
        $scope.projects=Projects.query()
      };

      $scope.createComment=function(id, text) {
          console.log(id+ " "+text);
          Tasks.newComment({id: id, text: text});
          $scope.projects = Projects.query()
      };
      $scope.deleteComment=function(id, taskId){
        Comments.delete({id:id, taskId: taskId});
        $scope.projects=Projects.query()
      };
    }]);