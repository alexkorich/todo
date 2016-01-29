 angular.module('todoList').factory('Tasks',function($resource){
  var data=$resource('/api/v1/tasks/:id',{id: '@id'}, {"newComment": {"method":"post", params: {id: '@id'}, url:"api/v1/tasks/:id/comments"}, 'update': { method:'PUT' }})
  return data;
});