class @TaskDetailController

  Review = null

  constructor: ($scope, $routeParams, Task, Tasks, DailyReview, DailyReviews) ->

    @id = $routeParams.taskId
    $scope.weeks = _.range(53)
    $scope.weekDays = _.range(7)

    $scope.task = Task.get {taskId: @id}, (task) =>

      @task = task
      @startDate = moment(task.created_at).startOf('day')

      DailyReviews.query {taskId: @id}, (data) =>
        @buildCalendar( data )

    $scope.updateReview = () =>

      $scope.review.$update {}, (review)=>
        if review.isNewRecord
          @reviews.push review
        else
          _.extend @getReviewByDate(review.date), review
        @updateCellOfReview review
        $('#edit-modal').modal('hide')

    @scope = $scope
    Review = DailyReview



  scope: ->


  buildCalendar: (reviews) ->
    self = @

    now = moment()

    @getCellByDate( @startDate ).html(
      "<i class='iconfont'>&#256;</i>"
    ).addClass 'beginning'

    @reviews = reviews
    _.each @reviews, (review) =>
      @updateCellOfReview( review )

    _.each $('.ui-calendar td'), (td) =>

      date = @getDateFromCell(td)

      $(td).toggleClass 'valid', @isTaskNeedDoneOn(date)

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
          @scope.review = new Review(review)

  getCellByDate: (date) ->
    date = moment(date) if $.type(date) == 'string'
    offset = Math.floor((date.valueOf() - @calendarStartDate().valueOf())/1000/60/60/24)
    x = Math.floor(offset / 7)
    y = offset % 7
    $('.ui-calendar td#cell_' + x + '_' + y)

  calendarStartDate: () ->
    start = moment(@startDate).startOf('month')
    one_year_ago = moment().subtract('year', 1)
    start = one_year_ago if start.isBefore(one_year_ago)
    start.startOf('week')

  getCellTip: (cell) ->
    date = @getDateStrFromCell(cell)
    if cell.hasClass('done')
      "<p>#{date}</p>DONE!"
    else if cell.hasClass('undone')
      "<p>#{date}</p>undone"
    else
      "<p>#{date}</p>not needed"

  getDateStrFromCell: (cell) ->
    @getDateFromCell(cell).format('YYYY-MM-DD')

  getDateFromCell: (cell) ->
    cell = $(cell)
    date = cell.data('date')
    return date if date

    coord = cell.attr('id').match(/^cell_(\d+)_(\d+)$/)
    x = parseInt coord[1]
    y = parseInt coord[2]
    @calendarStartDate().add('days', x * 7 + y )


  getReviewByCell: (cell) ->
    date = @getDateStrFromCell(cell)
    review = @getReviewByDate( date )
    if !review && @isTaskNeedDoneOn(date)
      review = { date: date, task_id: @task.id, done: false, isNewRecord: true }

    review

  getReviewByDate: (date) ->
    _.find @reviews, (review) ->
      review.date == date

  isTaskNeedDoneOn: (date) ->
    date = moment(date)
    !date.isBefore( @startDate ) && date.isBefore( moment() )

  updateCellOfReview: (review) ->
    cell = @getCellByDate review.date
    if cell && cell.length > 0
      cell.data('date', moment(review.date))
      cell.toggleClass 'done', review.done
      cell.toggleClass 'undone', !review.done

