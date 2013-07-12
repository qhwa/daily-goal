class @CheckController

  constructor: ($scope, Task, Tasks) ->
    $scope.tasks = Tasks.query({date: @yesterday()})

  yesterday: () ->
    moment().subtract( 'days', 1 ).format('YYYY-MM-DD')

