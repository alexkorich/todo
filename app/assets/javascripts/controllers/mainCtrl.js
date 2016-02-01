'use strict'
angular.module('todoList')
.controller("MainCtrl", [
  '$scope', '$timeout',"Projects","Tasks", "Comments", 'Upload',
  function($scope, $timeout, Projects, Tasks, Comments, Upload, $http){
      
    $scope.startSort={};
    $scope.newTask={};
    $scope.newProject={};
    $scope.isOpen = false;
    console.log($timeout)
    $scope.sortableOptions = {
      stop: function(e, ui) {
        console.log((ui.item.sortable.sourceModel));
        var a= findDiff($scope.startSort, ui.item.sortable.sourceModel);
        _.map(a, function(k) {
          Tasks.update({id: k.id, task:{position:k.position}})
        });
        $scope.loadProjects();
        },
      start: function(e, ui) {
        var a=ui;
        $scope.startSort=angular.copy(a.item.sortable.sourceModel);
        console.log($scope.startSort)
        },
      axis: 'y'
      };
      $scope.lol=function(lol){
        console.log(lol)
      }
    $scope.loadProjects = function() {
      Projects.query(function(data) {
        $timeout(function() {
        $scope.projects = data;
        console.log('Loaded!');
      })
        });
      };
  
    $scope.createProject=function(){
      console.log($scope.newProject)
      Projects.save({project:{name:$scope.newProject.name, deadline: new Date($scope.newProject.deadline)}});
      $scope.newProject={}
      $scope.isOpen = false;
      $scope.loadProjects()
      };

    $scope.updateProject=function(a){
      Projects.update({id:a.id, project:{name:a.name, deadline: new Date (a.deadline)}});
      $scope.loadProjects();
      };

    $scope.deleteProject=function(id){
      Projects.delete({id:id});
      $scope.loadProjects();
      };

    $scope.createTask=function(a, id){
      console.log(a, id);
      Projects.newTask({id:id, task:{name:a.name, done: false, deadline: new Date (a.deadline)}});
      $scope.loadProjects();
      };

    $scope.updateTask=function(task){
      
      Tasks.update({id:task.id, task:{name:task.name, deadline: new Date (task.deadline)}});
      $scope.loadProjects()
     }

    $scope.toggleTask=function(id, done){
      Tasks.update({id:id, task:{done:done}}, function(obj, getResponseHeaders){
        $scope.loadProjects();
        })
      };

    $scope.deleteTask=function(id){
      console.log(id);
      Tasks.delete({id:id});
      $scope.loadProjects();
      };

    $scope.createComment=function(id, text) {
      console.log(id+ " "+text);
      Tasks.newComment({id: id, text: text});
      $scope.loadProjects();
      };

    $scope.deleteComment=function(id, taskId){
      Comments.delete({id:id, taskId: taskId});
      $scope.loadProjects()
      };

    $scope.upload = function (file, id, tid) {
      console.log(id);
      Upload.upload({
        method:"PUT",
        url: 'api/v1/comments/'+id,
        data: {file: file, comment:tid}
        })
        .then(function (resp) {
          console.log('Success ' + resp.config.data.file.name + 'uploaded. Response: ' + resp.data);
          $scope.loadProjects()
        }, function (resp) {
          console.log('Error status: ' + resp.status);
        }, function (evt) {
          var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
          console.log('progress: ' + progressPercentage + '% ' + evt.config.data.file.name);
      });
      };

    function findDiff(arr1, arr2) {
        var length = arr1.length;
        var i = 0;
        var a = [];
        for (i; i < length; i++) {
            console.log(i);
            if (arr1[i].id != arr2[i].id) {
                a.push({id: arr2[i].id, position: i})
            }
        }
        return a
    }
    $scope.loadProjects();

    }]);