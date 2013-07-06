define [
	'backbone'
	], (
		Backbone
		) ->

	IndexView = Backbone.View.extend

		initialize: ->
			_.bindAll @
			@getInstagram()

		getInstagram: ->
			$.ajax
				type: 'GET'
				dataType: 'jsonp'
				url: "https://api.instagram.com/v1/users/20755768/media/recent/?access_token=20755768.06f8ba8.b52717186035436bac737b48cada2829&count=50"
				success: @haveInstagramData
			return

		instagramTemplate: _.template """
			<div class="instagram">
				<img src="<%= images.standard_resolution.url %>" />
				<% if(caption){ %>
					<p><%= caption.text %></p>
				<% } %>
			</div>
			"""

		haveInstagramData: (data) ->
			console.log 'data', data
			_.each @$('.cell'), (el, index) =>
				$el = $(el)
				gram = data.data[index]
				console.log gram
				$el.append @instagramTemplate gram
			# _.each data.data, (item) =>
				# console.log item
				# src = item.images.standard_resolution.url
				# $("#grid").append @instagramTemplate item