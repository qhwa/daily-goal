class @TaskDetailController

  constructor: ($scope, $routeParams, Task, Tasks) ->

    @id = $routeParams.taskId
    $scope.weeks = _.range(53)
    $scope.weekDays = _.range(7)

    $scope.task = Task.get {taskId: @id}, (data) =>
      @buildCalendar( data )

  buildCalendar: (task) ->
    _.each task.daily_reviews, (review) =>
      cell = @getCellByDate review.date
      if review.done
        cell.addClass 'done'
        cell.data('date', review.date)
      else
        cell.addClass 'undone'
        cell.data('date', review.date)

    _.each $('.ui-calendar td'), (td) =>
      self = @
      $(td).popover({
        html: true
        content: ->
          self.getCellTip( $(this) )
        container: 'body'
      })
      .on 'mouseover', (evt) ->
        $(this).popover('show')
      .on 'mouseleave', ->
        $(this).popover('hide')


  getCellByDate: (date) ->
    startDate = moment().subtract('year', 1).startOf('week')
    target = moment(date)
    offset = Math.floor((target.valueOf() - startDate.valueOf())/1000/60/60/24)
    x = Math.floor(offset / 7)
    y = offset % 7
    $('.ui-calendar td#cell_' + x + '_' + y)

  getCellTip: (cell) ->
    if cell.hasClass('done')
      "<p>#{cell.data('date')}</p>DONE!"
    else if cell.hasClass('undone')
      "<p>#{cell.data('date')}</p>undone"
    else
      "not needed"
