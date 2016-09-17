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

  .controller 'GameListCtrl', ($scope, Team, Game) ->
    $scope.games = Game.query()
    $scope.loadTeam = (id) ->
      console.log 'Get Team', id
      Team.get {id: id}, (team) ->
        return team
    $scope.destroy = (game) ->
      game.destroy () ->
        $scope.games.splice $scope.games.indexOf(game), 1

  .controller 'GameCreateCtrl', ($scope, $location, Team, Game) ->
    $scope.teams = Team.query()
    $scope.game =
      timeout: 10
      score1: 0
      score2: 0
    $scope.save = (game) ->
      game.timeout *= 60*1000
      Game.save JSON.stringify(game), (new_game) ->
        $location.path "/games/play/#{new_game._id.$oid}"

  .controller 'GamePlayCtrl', ($scope, $location, $routeParams, $timeout, $speechRecognition, Team, Game) ->
    Game.get {id: $routeParams.id}, (game) ->
      $scope.game = game
      $scope.timeout = game.timeout
      Team.get {id: $scope.game.team1}, (team) ->
        $scope.team1 = team
      Team.get {id: $scope.game.team2}, (team) ->
        $scope.team2 = team

    Pusher.logToConsole = true;

    pusher = new Pusher('cba436e88472fa7154a2', {
      cluster: 'eu',
      encrypted: true
    })

    channel = pusher.subscribe('gameshow')
    channel.bind 'button', (data) ->
      if $scope.listening
        $scope.unlisten()
        team = if data.id == "1" then $scope.team1 else $scope.team2
        $scope.$apply () ->
          $scope.buzzedFirst = team.name
          $speechRecognition.speak(team.name + '!')

    $scope.countdown = 0
    timeout_promise = undefined
    heartbeat = () ->
      $scope.timeout -= 1000
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
      $scope.timeout = $scope.game.timeout
    $scope.pauseTimer = () ->
      $timeout.cancel(timeout_promise)
      $scope.countdown = 0

    keydownListener = (e) ->
      $scope.unlisten()
      buzzed e.which - 48
    $scope.listen = () ->
      $scope.listening = 1
      addEventListener "keypress", keydownListener
    $scope.unlisten = () ->
      $scope.listening = undefined
      removeEventListener "keypress", keydownListener
    buzzed = (n) ->
      team = if n <= 4 then $scope.team1 else $scope.team2
      n = n - 4 if n > 4
      $scope.$apply () ->
        $scope.buzzedFirst = team["player#{n}"]
        $speechRecognition.speak(team.name + '! ' + team["player#{n}"] + '!')
    $scope.clearBuzzed = () ->
      $scope.buzzedFirst = undefined

    $scope.$watchCollection 'game', () ->
      $scope.game.update()
