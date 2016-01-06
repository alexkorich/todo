var todoList = angular.module('todoList', ['templates', 'ui.router' ])
    .config([
        '$stateProvider',
        '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider) {
            $stateProvider
                .state('home', {
                    url: '/',
                    templateUrl: 'home.html',
                    controller: 'MainCtrl'
                });

            $urlRouterProvider.otherwise('home');
        }])
    .controller("MainCtrl", [
        '$scope', '$state',
        function($scope, $state){
            $scope.test = 'Hello world!';
            $scope.varta = function(){
                $state.go('home');
            }
        }]);