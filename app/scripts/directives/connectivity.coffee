'use strict';

angular.module('angularToolkitApp')
.directive('connectivity', ($window, $parse) ->
	return ($scope, element, $attrs) ->
		
		# Parse attribute value into JSON
		events = $scope.$eval($attrs.connectivity)
		
		# Loop through events in JSON object
		angular.forEach events, (connEvent, eventName) ->
			
			# Parse event
			fn = $parse(connEvent)
			
			# Attach events to listeners		
			switch eventName
				when 'connect'
					$scope.connect = fn
					$window.addEventListener "online", ->
						console.log 'Detect Online Event'
						$scope.$apply ->
							fn($scope)
				when 'disconnect'
					$scope.disconnect = fn
					$window.addEventListener "offline", ->
						console.log 'Detect Offline Event'
						$scope.$apply ->
							fn($scope)
			
		# Run it once onload
		if navigator.onLine
			$scope.connect($scope)
		else
			$scope.disconnect($scope)
)