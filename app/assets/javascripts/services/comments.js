 angular.module('todoList').factory('comments', ['$http',function($http){
   var o = {
    comments: []
  };
  o.getAll = function() {
    return $http.get('api/v1/projects/tasks/comments.json').success(function(data){
      angular.copy(data, o.comments);
    });
  };
  return o;
}])