'use strict'

angular.module('UniversityChallengeApp')
  .controller 'MainCtrl', ($scope) ->
    $scope.team1 =
      name: 'Team 1'
      players:
        [
          'Player 1',
          'Player 2',
          'Player 3',
          'Player 4'
        ]
    $scope.team2 =
      name: 'Team 2'
      players:
        [
          'Player 1',
          'Player 2',
          'Player 3',
          'Player 4'
        ]
