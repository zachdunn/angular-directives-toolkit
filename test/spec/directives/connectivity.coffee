'use strict'

describe 'Directive: connectivity', () ->
  beforeEach module 'angularToolkitApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<connectivity></connectivity>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the connectivity directive'
