Promise = require 'bluebird'
{log, p, pjson} = require 'lightsaber'

{nodes, links} = require './fixtures/les-mis'
Claim          = require '../models/claim'

class Loader

  @demoData: ->
    Promise.all Promise.map links, @putLink, concurrency: 1

  @putLink: (link) ->
    source = nodes[link.source].name
    target = nodes[link.target].name
    value = link.value
    Claim.put { source, target, value }
      .then (messages) ->
        for message in messages
          "Rating saved to #{message}"

module.exports = Loader
