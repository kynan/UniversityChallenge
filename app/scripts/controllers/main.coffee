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
