class @CheckController

  constructor: ($scope, Task, Tasks, DailyReview) ->
    $scope.tasks = Tasks.query({date: @yesterday()})

    $scope.reviewStateChange = (evt) ->
      context = $(evt.target).closest('.task')
      taskId = context.data('task-id')
      task = _.find $scope.tasks, (task) ->
        task.id == taskId
      new DailyReview(task.review).$update()

  yesterday: () ->
    moment().subtract( 'days', 1 ).format('YYYY-MM-DD')

