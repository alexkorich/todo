 angular.module('todoList').factory('projects', ['$http',function($http){
   var o = {
    projects: []
  };
  o.getAll = function() {
    return $http.get('api/v1/projects.json').success(function(data){
      angular.copy(data, o.projects);
    });
  };
  return o;
}])