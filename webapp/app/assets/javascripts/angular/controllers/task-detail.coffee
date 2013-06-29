class window.TaskDetailController

  constructor: ($scope, $routeParams, Task, Tasks) ->

    $scope.task = Task.get({taskId: $routeParams.taskId})
