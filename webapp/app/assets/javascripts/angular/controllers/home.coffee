class @HomeController

  constructor: ($scope, Roles) ->
    $scope.roles = Roles.query (roles) =>
      if roles.length == 0
        $scope.mode = 'wizzard'
      else
        $scope.mode = 'check'
