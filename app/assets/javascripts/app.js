var todoList = angular.module('todoList', ['Devise','templates', 'ui.router' ])
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
        }])
    .controller("MainCtrl", [
        '$scope', '$state',"Auth",
        function($scope, $state, Auth){
            Auth.currentUser().then(function(user) {
                 console.log(user)
        }, function(error) {
            console.log(error.data.error)
            $state.go('login');
        });


            $scope.test = 'Hello world!';
            $scope.varta = function(){
                $state.go('login');
            }
        }])

    .controller("AuthCtrl", [
        '$scope', '$state',"Auth",
        function($scope, $state, Auth){
              $scope.login = function() {
                Auth.login($scope.user).then(function(){
                    $state.go('home');
                        });     
                    };
                     $scope.signUp = function(){
                         $state.go('register');


                     }
                  $scope.register = function() {
                    Auth.register($scope.user).then(function(){
                      $state.go('home');
                    });
                  };
        }]);