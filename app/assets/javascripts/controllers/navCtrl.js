 angular.module('todoList').controller('NavCtrl', ['$scope','Auth','$state','toastr',
function($scope, Auth, $state, toastr){

  $scope.signedIn = Auth.isAuthenticated;
  $scope.logout = Auth.logout;
    Auth.currentUser().then(function (user){
    $scope.user = user;
  });
     $scope.$on('devise:new-registration', function (e, user){
    $scope.user = user;
  });
  $scope.$on('devise:login', function (e, user){
    $scope.user = user;
    console.log(e)
    console.log(user)
    toastr.success("Hello, " +user.username+"!");
  });
  $scope.$on('devise:logout', function (e, user){
    $scope.user = {};
    $scope.projects={};
    $state.go('login');
    toastr.success("Bye!");

  });



}]);