 angular.module('todoList').factory('Comments', function($resource){
  return $resource('/api/v1/comments/:id', {id: '@id'});
});