 angular.module('todoList').factory('Projects', function($resource){
  var data=$resource('/api/v1/projects/:id',{id: '@id'}, {"newTask": {"method":"post", params: {id: '@id'}, url:"api/v1/projects/:id/tasks"}})
  return data;
})