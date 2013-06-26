angular.module('tasksServices', ['ngResource'])
  .factory 'Task', ($resource) ->
    $resource 'tasks/:taskId.json', {}, {
      show:   { method: 'GET' }
      update: { method: 'PUT' }
      destroy:{ method: 'DELETE' }
    }

  .factory 'Tasks', ($resource) ->
    $resource 'tasks.json', {}, {
      query:  { method: 'GET', isArray: true }
      create: { method: 'POST'}
    }
