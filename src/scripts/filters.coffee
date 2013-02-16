'use strict'

angular.module('UniversityChallengeApp')
  .filter 'minutes', () ->
    (time) ->
      min = Math.floor time / 60
      sec = time - min * 60
      if sec > 9 then "#{min}:#{sec}" else "#{min}:0#{sec}"
