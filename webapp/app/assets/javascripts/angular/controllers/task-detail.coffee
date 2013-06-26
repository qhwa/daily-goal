class @TaskDetailController

  constructor: ($scope, $routeParams, Task, Tasks) ->

    $scope.tasks = Tasks.query()
   
    $scope.addTask = () ->

      name = $scope.taskName

      Tasks.create { name: name }, (data) ->
          $scope.tasks.push {
            name:   name
            paused: false
          }

      $scope.taskName = ''

