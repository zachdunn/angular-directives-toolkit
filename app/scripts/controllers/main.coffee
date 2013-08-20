'use strict'

angular.module('angularToolkitApp')
.controller 'MainCtrl', ($scope, $rootScope, $window) ->

  $scope.photoFrame = 'https://buzzband.s3.amazonaws.com/photo_overlays/kiosk_106.png'

  #
  # Initialize
  #

  $scope.init = ->
    $window.document.title = 'AngularJS Toolkit'
    console.log 'ONLINE: ' + $rootScope.online
    $scope.cameraActive = true

  #
  # Callback for media publishing
  #

  $scope.publish = ->
    console.log 'Publishing media'

  #
  # Connectivity Events
  #

  $scope.onDisconnect = ->
    console.log 'Disconnect event'

  $scope.onConnect = ->
    console.log 'Connect Event'

  $scope.init()
