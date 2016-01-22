angular.module('todoList')
.controller("AuthCtrl", [
  '$scope', '$state',
  
  function($scope, $state){
    $scope.login = function() {
          
        };

     $scope.signUp = function(){
       $state.go('register');
       }

     $scope.register = function() {
      
      };


}]);