window.TaskCtrl = ($scope) ->

  $scope.tasks = [
    {name:'learn angular', paused:false},
    {name:'build an angular app', paused:false}]
 
  $scope.addTask = () ->
    $scope.tasks.push {
      name:$scope.taskName,
      paused:false
    }
    $scope.taskName = ''
 
  $scope.remaining = () ->
    count = 0
    angular.forEach($scope.todos, (todo) ->
      count += todo.done ? 0 : 1
    )
    return count
 
  $scope.archive = () ->
    oldTodos = $scope.todos
    $scope.todos = []
    angular.forEach(oldTodos, (todo) ->
      if !todo.done
        $scope.todos.push(todo)
    )
