class window.TaskDetailController

  constructor: ($scope, $routeParams, Task, Tasks) ->

    id = $routeParams.taskId
    $scope.task = Task.get({taskId: id})
    reviews = '/tasks/' + id + '/reviews.json'
    $('.ui-calendar').fullCalendar { events: reviews }
