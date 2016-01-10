angular.module('todoList')
.controller("MainCtrl", [
  '$scope', '$state',"Auth", "projects",
   function($scope, $state, Auth){
      Auth.currentUser().then(function(user) {
        console.log(user);
        $scope.user=user;
        }, function(error) {
            console.log(error.data.error)
            $state.go('login');
        });
            $scope.test = 'Hello world!';
            // $scope.projects = projects.projects;
        }]);