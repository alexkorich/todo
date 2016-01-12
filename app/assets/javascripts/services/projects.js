 angular.module('todoList').factory('Projects', function($resource){
  //  var o = {
  //   projects: []
  // };
  // o.getAll = function() {
  //   return $http.get('api/v1/projects.json').success(function(data){
  //     angular.copy(data, o.projects);
  //   });
  // };


  return $resource('/api/v1/projects/');
      
  // return o;
})