angular.module('todoList')
.controller("MainCtrl", [
  '$scope', "Projects","Tasks", "Comments", 'Upload',
   function($scope, Projects, Tasks, Comments, Upload, $http){
      $scope.newTask={};
      $scope.test = 'Hello world!';
      $scope.newProject={};
      $scope.projects=Projects.query();

      $scope.createProject=function(){
        Projects.save({project:{name:$scope.newProject.name, deadline:$scope.newProject.dateTime}})
        $scope.projects=Projects.query()
      };

      $scope.updateProject=function(name, deadline){
        Projects.save({project:{name:$scope.newProject.name, deadline:$scope.newProject.dateTime}})
        $scope.projects=Projects.query()
      };

      $scope.deleteProject=function(id){
        Projects.$delete({id:id});
        // $scope.projects=Projects.query()
      };


      $scope.createTask=function(id){
        console.log(id);
        Projects.newTask({id:id, task:{name:$scope.newTask.name}});
        $scope.projects=Projects.query()
      };

      //  $scope.updateTask=function(id){
      //   console.log(id);
      //   Tasks.delete({id:id});
      //   $scope.projects=Projects.query()
      // }


       $scope.deleteTask=function(id){
        console.log(id);
        Tasks.delete({id:id});
        $scope.projects=Projects.query()
      };

      $scope.createComment=function(id, text) {
          console.log(id+ " "+text);
          Tasks.newComment({id: id, text: text});
          $scope.projects = Projects.query()
      };
      $scope.deleteComment=function(id, taskId){
        Comments.delete({id:id, taskId: taskId});
        $scope.projects=Projects.query()
      };

      $scope.upload = function (file, id, tid) {
        console.log(id)
        Upload.upload({
            method:"PUT",
            url: 'api/v1/comments/'+id,
            data: {file: file, taskId:tid}
        }).then(function (resp) {
            console.log('Success ' + resp.config.data.file.name + 'uploaded. Response: ' + resp.data);
        }, function (resp) {
            console.log('Error status: ' + resp.status);
        }, function (evt) {
            var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
            console.log('progress: ' + progressPercentage + '% ' + evt.config.data.file.name);
        });
    };

    }]);