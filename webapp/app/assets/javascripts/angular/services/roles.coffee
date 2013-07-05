#TODO: make a module for Rails to prevent from repeating
angular.module('rolesServices', ['ngResource'])
  .factory 'Role', ($resource) ->
    $resource 'roles/:roleId.json', {}, {
      show:   { method: 'GET' }
      update: { method: 'PUT' }
      destroy:{ method: 'DELETE' }
    }

  .factory 'Roles', ($resource) ->
    $resource 'roles.json', {}, {
      query:  { method: 'GET', isArray: true }
      create: { method: 'POST'}
    }
