class @CreateTaskController

  constructor: ($scope, $location, Tasks, Roles) ->

    $scope.roles = Roles.query()

    $scope.addTask = () ->
      Tasks.create {
        role_id: $scope.role.id,
        name: $scope.taskName
      }, (task) ->
        $location.url('/task/' + task.id)

