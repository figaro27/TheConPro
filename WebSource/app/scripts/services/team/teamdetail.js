angular.module('estimateApp')
  .service('TeamDetail', ['BaseFactory', function (BaseFactory) {
    'use strict';

    var service = function(){
      BaseFactory.constructor.call(this, 'teamdetail');
    };

    service.prototype = Object.create(BaseFactory.constructor.prototype);
    service.prototype.constructor = service;

    return new service();

  }]);
