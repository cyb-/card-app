angular.module("cardApp").controller("ModalCardsController", ["$rootScope", "$scope", "$uibModalInstance", "player", function($rootScope, $scope, $uibModalInstance, player)
{
  $scope.player = player;
  $scope.selectedCard = null;

  $scope.select = function(index)
  {
    $uibModalInstance.close($scope.player.cards[index]);
  }

  $scope.cancel = function()
  {
    $uibModalInstance.dismiss();
  }
}]);
