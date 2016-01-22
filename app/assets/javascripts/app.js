angular.module('todoList', ['ng-token-auth','templates', 'ui.router', 'ngResource','ngFileUpload' ])
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
        controller: 'AuthCtrl'
        })
      .state('register', {
        url: '/register',
        templateUrl: 'register.html',
        controller: 'AuthCtrl'
        });    
      $urlRouterProvider.otherwise('login');
        }])
 .config(function($authProvider) {
        $authProvider.configure({
            apiUrl: 'localhost:3000'
        });
    });