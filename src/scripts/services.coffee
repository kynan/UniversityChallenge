'use strict'

angular.module('mongolab', ['ngResource'])
  .factory 'Team', ($resource) =>
    Team = $resource 'https://api.mongolab.com/api/1/databases/uni-challenge/collections/teams/:id'
    , {apiKey: 'h18zCyIluqeZTTcASk1tJBv-zOfNGgFi'}
    , update:
        method: 'PUT'

    Team.prototype.update = (cb) ->
      Team.update {id: @_id.$oid}
      , angular.extend({}, @, {_id: undefined})
      , cb

    Team.prototype.destroy = (cb) ->
      Team.remove id: @_id.$oid, cb

    return Team
  .factory 'Game', ($resource) =>
    Game = $resource 'https://api.mongolab.com/api/1/databases/uni-challenge/collections/games/:id'
    , {apiKey: 'h18zCyIluqeZTTcASk1tJBv-zOfNGgFi'}

    Game.create = (game, cb) ->
      game.timeout *= 60*1000
      game.score1 = 0
      game.score2 = 0
      Game.save JSON.stringify(game), cb

    Game.prototype.destroy = (cb) ->
      Game.remove id: @_id.$oid, cb

    return Game
