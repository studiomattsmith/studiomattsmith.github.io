requirejs.config
	baseUrl: '/assets/js/libs'
	paths:
		app: '../app'
		backbone: 'backbone'
	shim:
		backbone:
			deps: ['jquery', 'underscore']
			exports: 'Backbone'

require ["jquery", "underscore", "backbone"], () ->
	Main.init()

Main =
	init: ->
		# load views
		require [
			"app/views/index"
		], @extendViews

	extendViews: ->
		_.each $('.js-extend-view'), (el) =>
			$el = $(el)
			viewName = $el.data('view')
			return if viewName is null or viewName is undefined
			view = require("app/views/index")
			v = new view
				el: el
			$el.removeClass 'js-extend-view'