'use strict';

angular.module('angularToolkitApp')
.directive 'ngCamera', ->
  require: 'ngModel'
  template: '<div class="ng-camera clearfix">
    <p ng-hide="isLoaded">Loading Camera...</p>
    <div class="ng-camera-stack" ng-hide="!isLoaded">
      <img class="ng-camera-overlay" ng-src="{{overlaySrc}}" width="{{width}}" height="{{height}}">
      <video id="ng-camera-feed" autoplay width="{{width}}" height="{{height}}" src="{{videoStream}}">Install Browser\'s latest version</video>
      <canvas id="ng-photo-canvas" width="{{width}}" height="{{height}}" style="display:none;"></canvas>
    </div>
    <div class="row ng-camera-controls" ng-hide="!isLoaded">
      <button class="btn ng-camera-take-btn" ng-click="takePicture()">Take Picture</button>
      <button class="btn ng-camera-publish-btn" ng-click="publishCallback()">Publish</button>
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
    overlaySrc: '='
    publishCallback: '&publish'
  link: ($scope, element, $attrs, ngModel) ->

    # Remap common references
    navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia ||	navigator.mozGetUserMedia || navigator.msGetUserMedia
    window.URL = window.URL || window.webkitURL || window.mozURL || window.msURL

    #
    # Preloader for overlay image
    #
    $scope.$watch 'overlaySrc', (newVal, oldVal) ->
      # If an overlay was provided
      if $scope.overlaySrc?
        # We're waiting on this to load
        $scope.isLoaded = false
        preloader = new Image()
        preloader.crossOrigin = ''
        preloader.src = newVal
        preloader.onload = ->
          $scope.$apply ->
            $scope.isLoaded = true
      else
        # No frame. Skip it.
        $scope.isLoaded = true

    #
    # Turn on camera
    #
    $scope.enableCamera = ->
      navigator.getUserMedia
        audio: false
        video: true
      , (stream) ->
        $scope.$apply ->
          $scope.videoStream = window.URL.createObjectURL(stream)
    #
    # Turn off camera
    #
    $scope.disableCamera = ->
      navigator.getUserMedia
        audio: false
        video: true
      , (stream) ->
          $scope.$apply ->
            $scope.videoStream = ""

    #
    # Capture video stream as photo
    #

    $scope.takePicture = ->
      canvas = angular.element('#ng-photo-canvas')[0]

      if canvas?
        context = canvas.getContext('2d')
        # Draw current video feed to canvas (photo source)
        context.drawImage angular.element('#ng-camera-feed')[0], 0, 0, 640, 480
        if $scope.overlaySrc?
          $scope.addFrame context, $scope.overlaySrc, (image) ->
            # Wait for overlay image to load before making dataURL
            $scope.$apply ->
              $scope.media = canvas.toDataURL()
        else
          $scope.media = canvas.toDataURL()

    #
    # Add overlay to canvas render
    #
    $scope.addFrame = (context, url, callback = false) ->
      # Load returned overlay image and draw onto photo canvas
      overlay = new Image()
      overlay.crossOrigin = ''
      overlay.src = url
      overlay.onload = ->
        console.log 'Loaded'
        context.drawImage overlay, 0, 0, 640, 480
        callback(context) if callback

    #
    # Keep a packaged version of media ready
    #
    $scope.$watch 'media', (newVal) ->
      # Strip the Base64 prefix
      $scope.packagedMedia = $scope.media.replace /^data:image\/\w+;base64,/, "" if newVal?

    #
    # Check type of camera
    #
    $scope.$watch 'type', ->
      switch $scope.type
        when 'photo'
          console.log 'Camera type: Photo'
          $scope.enableCamera()
        when 'gif'
          console.log 'Camera type: GIF'
        when 'video'
          console.log 'Camera type: Video'
        else
          console.log 'Camera type: Defaulting to photo'
          $scope.enableCamera()