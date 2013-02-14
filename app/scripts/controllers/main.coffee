'use strict'

angular.module('UniversityChallengeApp')
  .controller 'TeamListCtrl', ($scope, Team) ->
    $scope.teams = Team.query()

  .controller 'TeamCreateCtrl', ($scope, $location, Team) ->
    $scope.save = () ->
      Team.save $scope.team, (team) ->
        $location.path '/teams'

  .controller 'TeamEditCtrl', ($scope, $location, $routeParams, Team) ->
    Team.get {id: $routeParams.id}, (team) =>
      @original = team
      $scope.team = new Team @original

    $scope.isClean = () =>
      angular.equals @original, $scope.team

    $scope.destroy = () =>
      @original.destroy () ->
        $location.path '/teams'

    $scope.save = () ->
      $scope.team.update () ->
        $location.path '/teams'

  .controller 'GameCreateCtrl', ($scope, $location, Team, Game) ->
    $scope.teams = Team.query()
    $scope.save = () ->
      Game.save $scope.game, (game) ->
        $location.path "/games/play/#{game._id.$oid}"

  .controller 'GamePlayCtrl', ($scope, $location, $routeParams, Team, Game) ->
    Game.get {id: $routeParams.id}, (game) ->
      $scope.game = game
      Team.get {id: $scope.game.team1}, (team) ->
        $scope.team1 = team
      Team.get {id: $scope.game.team2}, (team) ->
        $scope.team2 = team
