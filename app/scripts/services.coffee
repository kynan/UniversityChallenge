'use strict'

mongolabResource = (collection, $resource) ->
  database = 'https://api.mongolab.com/api/1/databases/uni-challenge/collections'

  Res = $resource "#{database}/#{collection}/:id"
  , {apiKey: 'h18zCyIluqeZTTcASk1tJBv-zOfNGgFi'}
  , update:
      method: 'PUT'

  Res.prototype.update = (cb) ->
    Res.update {id: @_id.$oid}
    , angular.extend({}, @, {_id: undefined})
    , cb

  Res.prototype.destroy = (cb) ->
    Res.remove id: @_id.$oid, cb

  return Res

angular.module('mongolab', ['ngResource'])
  .factory 'Team', ($resource) ->
    mongolabResource 'teams', $resource
  .factory 'Game', ($resource) ->
    mongolabResource 'games', $resource
