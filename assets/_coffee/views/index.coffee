define [
	'backbone'
	], (
		Backbone
		) ->

	IndexView = Backbone.View.extend

		initialize: ->
			_.bindAll @
			# @getInstagram()
			@getSvpply()
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

		tumblrTemplate: _.template """
			<a href="<%= link_url %>" target="_blank">
				<div class="image">
					<img src="<%= photos[0].original_size.url %>" />
				</div>
			</a>
			"""

		haveTumblrData: (data) ->
			_.each @$('.tumblr'), (el, index) =>
				$el = $(el)
				post = data.response.posts[index]
				$el.append @tumblrTemplate post
				$el.find('.preloader').remove()

		getSvpply: ->
			$.ajax
				type: 'GET'
				dataType: 'jsonp'
				url: 'https://api.svpply.com/v1/users/jarred/wants/products.json?callback=?'
				success: @haveSvpplyData

		svpplyTemplate: _.template """
		<a href="<%= page_url %>" target="_blank">
			<div class="image">
				<img src="<%= image %>" />
			</div>
			<div class="info">
				<h3><%= page_title %></h3>
				<h4>from <em><%= store.name %></em></h4>
			</div>
		</a>
		"""

		haveSvpplyData: (data) ->
			_.each @$('.svpply'), (el, index) =>
				$el = $(el)
				post = data.response.products[index]
				$el.append @svpplyTemplate post
				$el.find('.preloader').remove()