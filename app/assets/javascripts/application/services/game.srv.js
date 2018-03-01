angular.module("cardApp").service("GameService", ["$http", function($http)
{
  return {

    list: function()
    {
      return $http.get(Routes.api_v1_games_path());
    },

    get: function(id)
    {
      return $http.get(Routes.api_v1_game_path(id));
    },

    create: function(params)
    {
      return $http.post(Routes.api_v1_games_path(), { game: params });
    }

  }
}]);
