class @TaskDetailController

  Review = null

  constructor: ($scope, $routeParams, Task, Tasks, DailyReview, DailyReviews) ->

    @id = $routeParams.taskId
    $scope.weeks = _.range(53)
    $scope.weekDays = _.range(7)

    $scope.task = Task.get {taskId: @id}, (data) =>
      DailyReviews.query {taskId: @id}, (data) =>
        @buildCalendar( data )

    @scope = $scope
    Review = DailyReview



  scope: ->


  buildCalendar: (reviews) ->
    self = @
    @reviews = reviews
    _.each @reviews, (review) =>
      @updateCellOfReview( review )

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
          @scope.review = new Review(review)

    modal = $('#edit-modal')
    modal.on 'click', '.btn-save', (evt) =>
      modal.find('form').trigger('submit')

    modal.find('form').on 'submit', (evt) =>
      evt.preventDefault()
      @scope.review.$update {}, (review)=>
        _.extend @getReviewByDate(review.date), review
        @updateCellOfReview review
        $('#edit-modal').modal('hide')

  getCellByDate: (date) ->
    target = moment(date)
    offset = Math.floor((target.valueOf() - @_startDate().valueOf())/1000/60/60/24)
    x = Math.floor(offset / 7)
    y = offset % 7
    $('.ui-calendar td#cell_' + x + '_' + y)

  _startDate: () ->
    start = moment(@scope.task.created_at).startOf('month')
    one_year_ago = moment().subtract('year', 1)
    start = one_year_ago if start.isBefore(one_year_ago)
    start.startOf('week')

  getCellTip: (cell) ->
    date = @getDateFromCell(cell)
    if cell.hasClass('done')
      "<p>#{date}</p>DONE!"
    else if cell.hasClass('undone')
      "<p>#{date}</p>undone"
    else
      "<p>#{date}</p>not needed"

  getDateFromCell: (cell) ->
    cell = $(cell)
    date = cell.data('date')
    return date if date

    coord = cell.attr('id').match(/^cell_(\d+)_(\d+)$/)
    x = parseInt coord[1]
    y = parseInt coord[2]
    @_startDate().add('days', x * 7 + y ).format('YYYY-MM-DD')


  getReviewByCell: (cell) ->
    date = @getDateFromCell(cell)
    @getReviewByDate date

  getReviewByDate: (date) ->
    _.find @reviews, (review) ->
      review.date == date

  saveReview: ->
    $('#edit-modal form').submit()

  updateCellOfReview: (review) ->
    cell = @getCellByDate review.date
    if cell && cell.length > 0
      cell.data('date', review.date)
      cell.toggleClass 'done', review.done
      cell.toggleClass 'undone', !review.done

