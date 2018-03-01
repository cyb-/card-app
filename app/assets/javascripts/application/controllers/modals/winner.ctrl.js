angular.module("cardApp").controller("ModalWinnerController", ["$rootScope", "$scope", "$uibModalInstance", "$timeout", "PlayerService", "Player", "game", function($rootScope, $scope, $uibModalInstance, $timeout, PlayerService, Player, game)
{
  $scope.loading = true;
  $scope.game = game;
  $scope.winner = null;
  $scope.looser = null;
  $scope.winnerCount = null;
  $scope.looserCount = null;

  $scope.replay = function()
  {
    $rootScope.$broadcast("game:create");
    $timeout(function()
    {
      $uibModalInstance.close();
    }, 500);
  }

  PlayerService.winner($scope.game.id).then(function(response)
  {
    $scope.winner = Player.build(response.data.winner);
    $scope.looser = Player.build(response.data.looser);
    $scope.winnerCount = response.data.winner.fights_count;
    $scope.looserCount = response.data.looser.fights_count;
    $scope.loading = false;
  }, function(response)
  {
    $rootScope.$broadcast("flashes:add", { type: "danger", msg: "An error occured while loading game winner, please refresh !", timeout: 3000 })
    $scope.loading = false;
  });
}])
