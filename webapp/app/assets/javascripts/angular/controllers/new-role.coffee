class @NewRoleController

  constructor: ($scope) ->
    $scope.createRole = () ->
      role = { name: $scope.newRoleName }
      $scope.newRoleName = ''
      Roles.create role, (role) ->
        #TODO: goto role's page, to create tasks
        console.log 'role created', role

