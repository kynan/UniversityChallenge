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
      .otherwise
        redirectTo: '/'
  ]
