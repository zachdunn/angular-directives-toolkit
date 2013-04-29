'use strict';

angular.module('angularToolkitApp')
.directive('camera', ($parse) ->
  require: 'ngModel'
  template: '<div class="bb-camera">
  	<h1>{{title}}</h1>
  	<pre ng-hide="!debug">{{debug}}</pre>
  </div>'
  replace: true
  transclude: true
  restrict: 'E'
  scope:
  	type: '@'
  	media: '=ngModel'
  	publishCallback: '&onPublish'
  link: ($scope, element, $attrs, ngModel) ->

    $scope.title = "Camera"
    console.log navigator
		    
    # Figure out the context
    $scope.$watch 'type', ->    
	    switch $scope.type
	    	when 'photo'
	    		console.log 'Camera type: Photo'
	    		$scope.publishCallback()
	    	when 'gif'
	    		console.log 'Camera type: GIF'
	    	when 'video'
	    		console.log 'Camera type: Video'
	    	else
	    		console.log 'Camera type: Defaulting to photo'
)
