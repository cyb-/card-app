angular.module("cardApp").controller("HandController", ["$rootScope", "$scope", "$uibModal", "CardService", "Card", "Hand", function($rootScope, $scope, $uibModal, CardService, Card, Hand)
{
  $scope.loading = true;
  $scope.currentGame = $scope.gameScope.currentGame;
  $scope.hand = new Hand(null, $scope.player);
  $scope.gameScope.fight.addHand($scope.hand);

  $scope.selectCardModal = function()
  {
    var modalInstance = $uibModal.open({
      templateUrl: "modals/cards.html",
      controller: "ModalCardsController",
      size: "lg",
      resolve: {
        player: function(){ return $scope.player; }
      }
    });

    modalInstance.result.then(function(card)
    {
      $scope.hand.card  = card;
    });
  }

  $scope.selectCard = function(index)
  {
    $scope.hand.card = $scope.player.cards[index];
  }

  $scope.unselectCard = function()
  {
    $scope.hand.card = null;
  }

  $scope.loadCards = function()
  {
    $scope.loading = true;
    CardService.list($scope.player.id).then(function(response)
    {
      $scope.player.cards = Card.buildList(response.data.cards);
      if ($scope.player.cards.length)
        $rootScope.$broadcast("flashes:add", { type: "info", msg: "Cards for " + $scope.player.toString() + " was successfully loaded.", timeout: 3000 });
      else
        $rootScope.$broadcast("flashes:add", { type: "warning", msg: $scope.player.toString() + " has no cards !", timeout: 3000 });
      $scope.loading = false;
    }, function(response)
    {
      console.log("error while loading")
      $rootScope.$broadcast("flashes:add", { type: "danger", msg: "An error as occured while loading " + $scope.player.toString() + " cards.", timeout: 3000 });
      $scope.loading = false;
    });
  }

  $scope.$on("fight:new", function(e, datas)
  {
    $scope.hand = new Hand(null, $scope.player);
    $scope.gameScope.fight.addHand($scope.hand);
  });

  $scope.loadCards();
}]);
