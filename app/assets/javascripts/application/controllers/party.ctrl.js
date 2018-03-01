angular.module("cardApp").controller("PartyController", ["$rootScope", "$scope", "$timeout", "$uibModal", "FightService", "Fight", function($rootScope, $scope, $timeout, $uibModal, FightService, Fight)
{
  $scope.fighting = false;
  $scope.fight = new Fight();
  $scope.currentGame = null;

  $scope.isPlaying = function()
  {
    return $scope.currentGame != null && !$scope.currentGame.isFinished();
  }

  $scope.isFightable = function()
  {
    if ($scope.fight.hands.length < 2)
      return false;

    for(var i = 0; i < $scope.fight.hands.length; i++)
    {
      if (!$scope.fight.hands[i].card || !$scope.fight.hands[i].card.id)
        return false;
    }

    return true;
  }

  $scope.runFight = function()
  {
    $scope.fighting = true;
    FightService.create($scope.currentGame.id, $scope.fight.toParams()).then(function(response)
    {
      $scope.fight = Fight.build(response.data.fight);
      $scope.currentGame.fights.push($scope.fight);

      if ($scope.fight.winner)
        $rootScope.$broadcast("flashes:add", { type: "success", msg: $scope.fight.winner.toString() + " wins this fight !", timeout: 3000 });
      else
        $rootScope.$broadcast("flashes:add", { type: "warning", msg: "Equality between " + $scope.fight.hand1.player.toString() + " and " + $scope.fight.hand2.player.toString() + " for this fight !", timeout: 3000 });

      if ($scope.currentGame.isFinished())
      {
        $rootScope.$broadcast("game:finished", $scope.currentGame);
        $uibModal.open({
          templateUrl: "modals/winner.html",
          controller: "ModalWinnerController",
          backdrop: "static",
          size: "sm",
          windowClass: "vertically-centered-xs",
          resolve: {
            game: function(){ return $scope.currentGame; }
          }
        });
        $scope.fighting = false;
      }
      else
      {
        $timeout(function()
        {
          $scope.fight = new Fight();
          $scope.$broadcast("fight:new");
          $scope.fighting = false;
        }, 2500);
      }
    }, function(response)
    {
      $rootScope.$broadcast("flashes:add", { type: "danger", msg: "An error as occured while fighting, please retry !", timeout: 3000 });
      $scope.fighting = false;
    });
  }

  $scope.newGame = function()
  {
    var modalInstance = $uibModal.open({
      templateUrl: "modals/new-game.html",
      controller: "ModalNewGameController",
      backdrop: "static",
      size: "sm",
      windowClass: "vertically-centered-xs"
    });

    modalInstance.result.then(function(game)
    {
      $scope.currentGame = game;
      $scope.fight = new Fight();
      $rootScope.$broadcast("game:selected", $scope.currentGame);
    });
  }

  $rootScope.$on("game:create", function(e)
  {
    $scope.newGame();
  });

  $scope.newGame();
}]);
