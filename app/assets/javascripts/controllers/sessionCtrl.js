angular.module('todoList')
.controller("SessionCtrl", [
  '$scope', '$state',
  
  function($rootScope, $scope, $state){
    $scope.handleLoginBtnClick = function() {
      $auth.submitLogin($scope.loginForm)
        .then(function(resp) {
          console.log('lil')
        })
        .catch(function(resp) {
          console.log('lel')
        });
    };

$rootScope.$on('auth:login-success', function(ev, user) {
    alert('Welcome ', user.email);
});
}]);