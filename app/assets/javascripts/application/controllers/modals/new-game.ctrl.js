angular.module("cardApp").controller("ModalNewGameController", ["$rootScope", "$scope", "$uibModalInstance", "PlayerService", "Player", "GameService", "Game", function($rootScope, $scope, $uibModalInstance, PlayerService, Player, GameService, Game)
{
  $scope.loading = true;
  $scope.saving = false;
  $scope.player1Id;
  $scope.player2Id;

  $scope.ok = function()
  {
    $scope.saving = true;
    GameService.create({player_ids: [$scope.player1Id, $scope.player2Id]}).then(function(response)
    {
      $rootScope.$broadcast("flashes:add", { type: "success", msg: "Your game was successfully created.", timeout: 3000 });
      $uibModalInstance.close(Game.build(response.data.game));
      $scope.saving = false;
    }, function(response)
    {
      $rootScope.$broadcast("flashes:add", { type: "danger", msg: "An error as occured, please retry !", timeout: 3000 });
      $scope.saving = false;
    });
  }

  PlayerService.list().then(function(response)
  {
    $scope.players = Player.buildList(response.data.players);
    $scope.loading = false;
  }, function(response)
  {
    $rootScope.$broadcast("flashes:add", { type: "danger", msg: "An error as occured, please retry !", timeout: 3000 });
    $scope.loading = false;
  });
}]);
