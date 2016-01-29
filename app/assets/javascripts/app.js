angular.module('todoList', ['Devise','templates','ngAnimate', 'ui.router', 'ui.sortable','ui.bootstrap' ,'ngResource',
                            'ngFileUpload', 'ui.bootstrap.datetimepicker' ])
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
        }]);