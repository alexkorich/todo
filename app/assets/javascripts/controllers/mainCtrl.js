angular.module('todoList')
.controller("MainCtrl", [
  '$scope', "Projects","Tasks", "Comments", 'Upload',
   function($scope, Projects, Tasks, Comments, Upload, $http, $timeout){
    $scope.startSort={};
  $scope.loadProjects = function() {
      Projects.query(function(data) {
        $scope.projects = data;
      });
    };
  
      $scope.opened={}
      $scope.loadProjects();
      $scope.newTask={};
      $scope.test = 'Hello world!';
      $scope.newProject={};


 
      $scope.isOpen = false;

      $scope.createProject=function(){
        Projects.save({project:{name:$scope.newProject.name, deadline:$scope.newProject.dateTime}})
       $scope.loadProjects()
      };

      $scope.updateProject=function(name, deadline){
        Projects.save({project:{name:$scope.newProject.name, deadline:$scope.newProject.dateTime}})
       $scope.loadProjects()
      };

      $scope.deleteProject=function(id){
        Projects.delete({id:id});
        $scope.loadProjects()
      };
      $scope.sortableOptions = {
      stop: function(e, ui) {
        console.log(ui.item.sortable.sourceModel==$scope.startSort)
        console.log(ui.item.sortable.sourceModel)
        
      },
      start: function(e, ui) {
        var a=ui
        // $scope.startSort=angular.copy(a.item.sortable.sourceModel);
        console.log($scope.startSort)
      },
    };

      $scope.createTask=function(a, id){
        console.log(a, id);
        Projects.newTask({id:id, task:{name:a.name, deadline:a.deadline}});
       $scope.loadProjects()
      };

      //  $scope.updateTask=function(id){
      //   console.log(id);
      //   Tasks.delete({id:id});
      //  $scope.loadProjects()
      // }
      $scope.toggleTask=function(id, done){
        Tasks.update({id:id, task:{done:done}}, function(obj, getResponseHeaders){
        console.log(obj);
        $scope.loadProjects();
        })
      };

       $scope.deleteTask=function(id){
        console.log(id);
        Tasks.delete({id:id});
       $scope.loadProjects()
      };

      $scope.createComment=function(id, text) {
          console.log(id+ " "+text);
          Tasks.newComment({id: id, text: text});
       $scope.loadProjects()
          
      };
      $scope.deleteComment=function(id, taskId){
        Comments.delete({id:id, taskId: taskId});
       $scope.loadProjects()
      };

      $scope.upload = function (file, id, tid) {
        console.log(id)
        Upload.upload({
            method:"PUT",
            url: 'api/v1/comments/'+id,
            data: {file: file, comment:tid}
        }).then(function (resp) {
            console.log('Success ' + resp.config.data.file.name + 'uploaded. Response: ' + resp.data);
       $scope.loadProjects()
            
        }, function (resp) {
            console.log('Error status: ' + resp.status);
        }, function (evt) {
            var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
            console.log('progress: ' + progressPercentage + '% ' + evt.config.data.file.name);
        });
    };

    }]);