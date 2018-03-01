angular.module("cardApp").directive("hand", ["$rootScope", function($rootScope)
{
  return {
    restrict: "E",
    replace: true,
    scope: {
      player: '=',
      gameScope: '='
    },
    templateUrl: "hand.html",
    controller: "HandController",
    link: function(scope, elm, attrs)
    {

    }
  }
}]);
