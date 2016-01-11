 angular.module('todoList').factory('tasks', ['$http',function($http){
   var o = {
    tasks: []
  };
  o.getAll = function() {
    return $http.get('api/v1/projects/tasks.json').success(function(data){
      angular.copy(data, o.tasks);
    });
  };
  return o;
}])