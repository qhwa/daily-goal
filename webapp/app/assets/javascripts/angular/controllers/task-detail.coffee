class @TaskDetailController

  constructor: ($scope, $routeParams, Task, Tasks) ->

    @id = $routeParams.taskId
    $scope.weeks = _.range(53)
    $scope.weekDays = _.range(7)

    $scope.task = Task.get {taskId: @id}, (data) =>
      @buildCalendar( data )

    @scope = $scope



  scope: ->


  buildCalendar: (task) ->
    self = @
    @reviews = task.daily_reviews
    _.each @reviews, (review) =>
      cell = @getCellByDate review.date
      if review.done
        cell.addClass 'done'
        cell.data('date', review.date)
      else
        cell.addClass 'undone'
        cell.data('date', review.date)

    _.each $('.ui-calendar td'), (td) =>
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


    $('.ui-calendar').on 'click', 'td', (evt) =>
      review = @getReviewByCell( evt.currentTarget )
      if review
        $('#edit-modal').modal('show')
        @scope.$apply =>
          console.log review
          @scope.review = review


  getCellByDate: (date) ->
    target = moment(date)
    offset = Math.floor((target.valueOf() - @_startDate().valueOf())/1000/60/60/24)
    x = Math.floor(offset / 7)
    y = offset % 7
    $('.ui-calendar td#cell_' + x + '_' + y)

  _startDate: () ->
    moment().subtract('year', 1).startOf('week')

  getCellTip: (cell) ->
    if cell.hasClass('done')
      "<p>#{cell.data('date')}</p>DONE!"
    else if cell.hasClass('undone')
      "<p>#{cell.data('date')}</p>undone"
    else
      "not needed"

  getReviewByCell: (cell) ->
    coord = $(cell).attr('id').match(/^cell_(\d+)_(\d+)$/)
    x = parseInt coord[1]
    y = parseInt coord[2]
    date = @_startDate().add('days', x * 7 + y ).format('YYYY-MM-DD')
    _.find @reviews, (review) ->
      review.date == date

