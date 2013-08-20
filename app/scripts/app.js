'use strict';

angular.module('angularToolkitApp', ['omr.directives'])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  }).run(function($rootScope, $window){
  	
  	if ($window.navigator.onLine){
	  	$rootScope.online = true;
  	}else{
	  	$rootScope.online = false;	
  	}
  	
	  $window.addEventListener('online', function(){
		  $rootScope.online = true;
	  });
	  $window.addEventListener('offline', function(){
		  $rootScope.online = false;
	  })
  });
