(function($){
  var id = '<%= @review.id %>',
      done = <%= @review.done? %>,
      html = '<%= j( render partial: "daily_review", object: @review ) %>';

  $('#daily_review_' + id)
    .toggleClass('done', done)
    .html( html );

})(jQuery)
