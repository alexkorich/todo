angular.module('todoList')
.controller("MainCtrl", [
  '$scope', '$state', "projects",
   function($scope, $state, projects){
    projects.getAll()
            $scope.projects=projects.projects
            $scope.test = 'Hello world!';
            console.log($scope.projects)
            // $scope.projects = projects.projects;
        }]);