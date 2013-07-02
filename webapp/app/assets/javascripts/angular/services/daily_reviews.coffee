angular.module('dailyReviewsServices', ['ngResource'])
  .factory 'DailyReview', ($resource) ->
    $resource 'tasks/:taskId/reviews/:date.json', { taskId: '@task_id', date: '@date' }, {
      show:   { method: 'GET' }
      update: { method: 'PUT' }
      destroy:{ method: 'DELETE' }
    }

  .factory 'DailyReviews', ($resource) ->
    $resource 'tasks/:taskId/reviews.json', {}, {
      query:  { method: 'GET', isArray: true }
      create: { method: 'POST'}
    }
