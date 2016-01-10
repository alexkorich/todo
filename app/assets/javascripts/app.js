angular.module('todoList', ['Devise','templates', 'ui.router', 'ngResource' ])
    .config([
        '$stateProvider',
        '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
            $stateProvider
                .state('home', {
                    url: '/',
                    templateUrl: 'home.html',
                    controller: 'MainCtrl'
                })
                .state('login', {
                    url: '/login',
                    templateUrl: 'login.html',
                    controller: 'AuthCtrl',  onEnter: ['$state', 'Auth', function($state, Auth) {
                        Auth.currentUser().then(function (){
                            $state.go('home');
                                })
                              }]
                })
                .state('register', {
                    url: '/register',
                    templateUrl: 'register.html',
                    controller: 'AuthCtrl',
                     onEnter: ['$state', 'Auth', function($state, Auth) {
                        Auth.currentUser().then(function (){
                        $state.go('home');
                         })
                        }]
                });
            $urlRouterProvider.otherwise('login');
        }]).factory('projects', ['$http',function($http){
   var o = {
    projects: []
  };


  o.getAll = function() {
    return $http.get('/projects.json').success(function(data){
      angular.copy(data, o.projects);
    });
  };
  return o;
}])

        .controller('NavCtrl', [
'$scope',
'Auth',
function($scope, Auth){
  $scope.signedIn = Auth.isAuthenticated;
  $scope.logout = Auth.logout;
}]);
