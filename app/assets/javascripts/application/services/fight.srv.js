angular.module("cardApp").service("FightService", ["$http", function($http)
{
  return {

    list: function()
    {
      return $http.get(Routes.api_v1_game_fights_path(gameId));
    },

    create: function(gameId, params)
    {
      return $http.post(Routes.api_v1_game_fights_path(gameId), { fight: params });
    }

  }
}]);
