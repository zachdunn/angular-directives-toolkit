'use strict'

angular.module('angularToolkitApp')
.controller 'MainCtrl', ($scope, $rootScope, $document) ->
	
	#
	# Initialize
	#
	
	$scope.init = ->
		$document.title = 'AngularJS Toolkit'
		console.log 'ONLINE: ' + $rootScope.online
	
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
