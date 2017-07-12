define [
	'backbone'
	], (
		Backbone
		) ->

	IndexView = Backbone.View.extend

		tumblrPage: 0

		initialize: ->
			_.bindAll @
			# @getInstagram()
			# @getSvpply()
			@getTumblr()

		getInstagram: ->
			$.ajax
				type: 'GET'
				dataType: 'jsonp'
				url: "https://api.instagram.com/v1/users/5725120139/media/recent/?access_token=5725120139.4de2eb0.d716395e1cd7453da234aed6cce5b8c5""
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

		getTumblr: (offset=0)->
			@currentTumblr = 0
			$.ajax
				url: ''
				dataType: 'jsonp'
				type: 'GET'
				data:
					api_key: "YgpsEXCrpCtKL9U7aNBzWeDp0sSbZw1AeZQSt5QgsXRLdb5o24"
					limit: 50
					offset: Number(offset)
				success: @haveTumblrData

		tumblrTemplate: _.template """
			<a href="<%= link_url %>" target="_blank">
				<div class="image">
					<img src="<%= photos[0].original_size.url %>" />
				</div>
			</a>
			"""

		haveTumblrData: (data) ->
			_.each @$('.tumblr-empty'), (el, index) =>
				$el = $(el)
				post = data.response.posts[index]
				return if post is undefined
				$el.append @tumblrTemplate post
				$el.find('.preloader').remove()
				$el.removeClass 'tumblr-empty'

			if @$('.tumblr-empty').length > 0
				@getTumblr @currentTumblr+1

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
