'use strict'

angular.module('uniChallengeApp', [
  'ngResource',
  'ngRoute'
])
  .config ['$routeProvider', ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .otherwise
        redirectTo: '/'
  ]
