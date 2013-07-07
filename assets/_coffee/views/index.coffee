define [
	'backbone'
	], (
		Backbone
		) ->

	IndexView = Backbone.View.extend

		initialize: ->
			_.bindAll @
			@getInstagram()
			@getTumblr()

		getInstagram: ->
			$.ajax
				type: 'GET'
				dataType: 'jsonp'
				url: "https://api.instagram.com/v1/users/14250732/media/recent/?access_token=16304963.457f60c.d89e49ea943c44e29308004e99a9d8da&count=100"
				success: @haveInstagramData
			return

		instagramTemplate: _.template """
			<img src="<%= images.standard_resolution.url %>" />
			<% if(caption){ %>
				<p><%= caption.text %></p>
			<% } %>
			"""

		haveInstagramData: (data) ->
			_.each @$('.instagram'), (el, index) =>
				$el = $(el)
				gram = data.data[index]
				if gram?
					$el.append @instagramTemplate gram

		getTumblr: ->
			$.ajax
				url: 'http://api.tumblr.com/v2/blog/commonthings.tumblr.com/posts'
				dataType: 'jsonp'
				type: 'GET'
				data:
					api_key: "YgpsEXCrpCtKL9U7aNBzWeDp0sSbZw1AeZQSt5QgsXRLdb5o24"
					limit: 20
					offset: 0
				success: @haveTumblrData

		haveTumblrData: (data) ->
			# console.log 'haveTumblrData', data
			_.each @$('.tumblr'), (el, index) =>
				$el = $(el)
				post = data.response.posts[index]
				console.log post