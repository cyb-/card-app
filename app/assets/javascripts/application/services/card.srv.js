angular.module("cardApp").service("CardService", ["$http", function($http)
{
  return {

    list: function(playerId)
    {
      return $http.get(Routes.api_v1_player_cards_path(playerId));
    },

    get: function(id)
    {
      return $http.get(Routes.api_v1_card_path(id));
    }

  }
}]);
