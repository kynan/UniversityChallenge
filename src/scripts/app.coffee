'use strict'

angular.module('UniversityChallengeApp', ['mongolab'])
  .config ['$routeProvider', ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
      .when '/teams',
        templateUrl: 'views/teams.html'
        controller: 'TeamListCtrl'
      .when '/teams/new',
        templateUrl: 'views/edit.html'
        controller: 'TeamCreateCtrl'
      .when '/teams/edit/:id',
        templateUrl: 'views/edit.html'
        controller: 'TeamEditCtrl'
      .when '/games',
        templateUrl: 'views/games.html'
        controller: 'GameListCtrl'
      .when '/games/new',
        templateUrl: 'views/startgame.html'
        controller: 'GameCreateCtrl'
      .when '/games/play/:id',
        templateUrl: 'views/playgame.html'
        controller: 'GamePlayCtrl'
      .otherwise
        redirectTo: '/'
  ]
