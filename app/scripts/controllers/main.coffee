'use strict'

angular.module('angularToolkitApp')
.controller 'MainCtrl', ($scope, $rootScope, $document) ->

	#
	# Initialize
	#
	
	$scope.init = ->
		$document.title = 'AngularJS Toolkit'
		console.log 'ONLINE: ' + $rootScope.online
		$scope.photoFrame = 'http://buzzband.s3.amazonaws.com/photo_overlays/kiosk_106.png'
	#
	# Callback for media publishing
	#
	
	$scope.publish = ->
		console.log 'Publishing media'
		
	$scope.onDisconnect = ->
		console.log 'Disconnect event'
		
	$scope.onConnect = ->
		console.log 'Connect Event'
	
	$scope.init()
