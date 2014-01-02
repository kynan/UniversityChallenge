'use strict'

angular.module('UniversityChallengeApp')
  .directive 'team', () ->
    replace: true
    restrict: 'E'
    scope:
      countdown: '='
      editable: '='
      score: '='
      team: '='
    templateUrl: 'views/team.html'
