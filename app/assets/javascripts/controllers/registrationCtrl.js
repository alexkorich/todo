angular.module('todoList')
.controller("RegistrationCtrl", [
  '$scope','$auth',
  
  function($scope, $auth){
  $scope.handleRegBtnClick = function() {
      $auth.submitRegistration($scope.registrationForm)
        .then(function() {
         console.log("response")
        })
        .catch(function(response) {
          console.log(response)
        });
    };



}]);