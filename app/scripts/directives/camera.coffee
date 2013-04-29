'use strict';

angular.module('angularToolkitApp')
.directive('camera', ($parse) ->
	require: 'ngModel'
	template: '<div class="bb-camera">
		<video id="bb-camera-feed" autoplay width="{{width}}" height="{{height}}" src="{{videoStream}}">Install Browser\'s latest version</video>
		<canvas id="bb-photo-canvas" width="{{width}}" height="{{height}}" style="display:none;"></canvas>
		<div class="row">
			<button class="btn" ng-click="takePicture()">Take Picture</button>
			<button class="btn" ng-click="publishCallback()">Publish</button>
		</div>
	</div>'
	replace: true
	transclude: true
	restrict: 'E'
	scope:
		type: '@'
		media: '=ngModel'
		width: '@'
		height: '@'
		overlaySrc: '@'
		publishCallback: '&publish'
	link: ($scope, element, $attrs, ngModel) ->

		# Remap references
		navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia ||	navigator.mozGetUserMedia || navigator.msGetUserMedia
		window.URL = window.URL || window.webkitURL || window.mozURL || window.msURL
		
		#
		# Turn on camera
		#
		navigator.getUserMedia
			audio: false,
			video: true,
			(stream) =>
				$scope.$apply ->
					$scope.videoStream = window.URL.createObjectURL(stream)
			, (e) ->
				console.log e
		
		$scope.takePicture = ->			
			canvas = angular.element('#bb-photo-canvas')[0]

			if canvas?
				context = canvas.getContext('2d')
				
				# Draw current video feed to canvas (photo source)
				context.drawImage angular.element('#bb-camera-feed')[0], 0, 0, 640, 480
				
				if $scope.overlaySrc?				
					$scope.addFrame context, $scope.overlaySrc, (image) ->
						# Wait for overlay image to load before making dataURL
						$scope.media = canvas.toDataURL()
				else
					$scope.media = canvas.toDataURL()
					
		$scope.addFrame = (context, url, callback = false) ->
			# Load returned overlay image and draw onto photo canvas
			overlayFrame = new Image()
			overlayFrame =
				crossOrigin: ''
				src: url
				onload: =>
					context.drawImage overlayFrame, 0, 0, 640, 480
					callback(context) if callback
			
		$scope.$watch 'media', (newVal) ->
			if newVal?
				# Strip the Base64 prefix
				$scope.packagedMedia = $scope.media.replace /^data:image\/\w+;base64,/, ""
				
		# Check type of camera
		$scope.$watch 'type', ->
			switch $scope.type
				when 'photo'
					console.log 'Camera type: Photo'
				when 'gif'
					console.log 'Camera type: GIF'
				when 'video'
					console.log 'Camera type: Video'
				else
					console.log 'Camera type: Defaulting to photo'
)
