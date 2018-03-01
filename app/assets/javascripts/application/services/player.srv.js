angular.module("cardApp").service("PlayerService", ["$http", function($http)
{
  return {

    list: function()
    {
      return $http.get(Routes.api_v1_players_path());
    },

    get: function(id)
    {
      return $http.get(Routes.api_v1_player_path(id));
    },

    winner: function(gameId)
    {
      return $http.get(Routes.api_v1_game_winner_path(gameId));
    }

  }
}]);
