'use strict'

describe 'Directive: camera', () ->
  beforeEach module 'angularToolkitApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<camera></camera>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the camera directive'
