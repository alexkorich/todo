angular.module('todoList', ['ng-token-auth','templates', 'ui.router', 'ngResource','ngFileUpload' ])
.config([
  '$stateProvider',
  '$urlRouterProvider',
  function($stateProvider, $urlRouterProvider) {
    $stateProvider
      .state('home', {
        url: '/',
        templateUrl: 'home.html',
        controller: 'MainCtrl',
        resolve: {
          auth: function($auth) {
            return $auth.validateUser().catch(function(resp) {
            $state.go('login')
        });
          }
        }})
      .state('login', {
        url: '/login',
        templateUrl: 'login.html',
        controller: 'SessionCtrl'
        })
      .state('register', {
        url: '/register',
        templateUrl: 'register.html',
        controller: 'RegistrationCtrl'
        });    
      $urlRouterProvider.otherwise('login');
        }])


 .config(function($authProvider) {
        $authProvider.configure({
            apiUrl: ''
        });
    });