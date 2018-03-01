angular.module("cardApp").controller("NavController", ["$rootScope", "$scope", function($rootScope, $scope)
{
  $scope.newGame = function()
  {
    $rootScope.$broadcast("game:create");
  }
}]);
