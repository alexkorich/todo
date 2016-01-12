angular.module('todoList')
.controller("MainCtrl", [
  '$scope', "Projects",
   function($scope, Projects){
            // $scope.projects=projects.projects
            $scope.test = 'Hello world!';
            // console.log($scope.projects)
            // // $scope.projects = projects.projects;
            // $scope.createProject=function(){
            //   projects.createNew()
            // }
            
            console.log(Object.getOwnPropertyNames(Projects))
            $scope.projects=Projects.query()

        }]);