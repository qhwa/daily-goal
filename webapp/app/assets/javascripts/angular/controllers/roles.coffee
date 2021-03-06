class @RolesController

  constructor: ($scope, Roles, Role) ->
    $scope.roles = Roles.query()

    $scope.createRole = () ->
      role = { name: $scope.newRoleName }
      $scope.newRoleName = ''
      Roles.create role, (role) ->
        $scope.roles.push role

    $scope.destroyRole = (evt) ->
      evt.preventDefault()
      return if !confirm("Are you sure to destroy this role?")
      context = $(evt.target).closest('.role')
      id = context.data('role-id')

      new Role().$destroy {roleId: id}, () ->
        context.hide('slow')

