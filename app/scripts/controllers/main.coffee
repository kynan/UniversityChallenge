'use strict'

angular.module('UniversityChallengeApp')
  .filter 'minutes', () ->
    (time) ->
      min = Math.floor time / 60
      sec = time - min * 60
      "#{min}:#{sec}"
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
    $scope.game =
      timeout: 10
    $scope.save = () ->
      Game.save $scope.game, (game) ->
        $location.path "/games/play/#{game._id.$oid}"

  .controller 'GamePlayCtrl', ($scope, $location, $routeParams, $timeout, Team, Game) ->
    $scope.countdown = 0
    timeout_promise = undefined
    Game.get {id: $routeParams.id}, (game) ->
      $scope.game = game
      $scope.timeout = game.timeout*60
      Team.get {id: $scope.game.team1}, (team) ->
        $scope.team1 = team
      Team.get {id: $scope.game.team2}, (team) ->
        $scope.team2 = team

    countDown = () ->
      $scope.timeout--
    heartbeat = () ->
      $scope.timeout--
      if $scope.countdown && $scope.timeout > 0
        timeout_promise = $timeout heartbeat, 1000
      else if $scope.timeout == 0
        alert "Time is up!"

    $scope.startTimer = () ->
      $scope.countdown = 1
      timeout_promise = $timeout heartbeat, 1000
    $scope.resetTimer = () ->
      $timeout.cancel(timeout_promise)
      $scope.countdown = 0
      $scope.timeout = $scope.game.timeout*60
    $scope.pauseTimer = () ->
      $timeout.cancel(timeout_promise)
      $scope.countdown = 0
