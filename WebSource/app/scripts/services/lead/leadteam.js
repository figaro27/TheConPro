angular.module('estimateApp')
  .service('LeadTeam', ['BaseFactory', function (BaseFactory) {
    'use strict';

    var service = function(){
      BaseFactory.constructor.call(this, 'teamlead');
    };

    service.prototype = Object.create(BaseFactory.constructor.prototype);
    service.prototype.constructor = service;

    return new service();
  }]);
