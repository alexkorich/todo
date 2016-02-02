angular.module('todoList')
.controller("AuthCtrl", [
  '$scope', '$state',"Auth",'toastr',
  
  function($scope, $state, Auth, toastr){
    $scope.login = function() {

      Auth.login($scope.user).then(function(){
        $state.go('home');

          }, function(error){toastr.error(error.data.error);});     
        };

     $scope.signUp = function(){
       $state.go('register');
       }

     $scope.register = function() {
      Auth.register($scope.user).then(function(){
        $state.go('home');
        }, function(error){
          $.each(error.data.errors, function(index, value) {
            toastr.error(index.charAt(0).toUpperCase()+index.slice(1)+" "+value)
            }); 
          })
          
        };


}]);