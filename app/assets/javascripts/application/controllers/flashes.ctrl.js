angular.module("cardApp").controller("FlashesController", ["$rootScope", "$scope", "Flash", function($rootScope, $scope, Flash)
{
  $scope.flashes = [];

  $scope.$on('flashes:add', function(e, datas)
  {
    $scope.addFlash(Flash.build(datas));
  });

  $scope.addFlash = function(flash)
  {
    $scope.flashes.push(flash);
  }

  $scope.closeFlash = function(index)
  {
    $scope.flashes.splice(index, 1);
  }
}]);
