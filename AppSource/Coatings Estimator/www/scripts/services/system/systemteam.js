angular.module('estimateApp')
  .service('SystemTeam', ['Service', 'BaseFactory', function (Service,BaseFactory) {
    'use strict';
    var service = function(){
      BaseFactory.constructor.call(this, 'teamsystem');
    };

    var url = {
      search: 'api/v1/teamsystem/search',
      add: 'api/v1/teamsystem',
      update: 'api/v1/teamsystem',
      remove: 'api/v1/teamsystem'
    };

    service.GetAll = function () {
      var searchCriteria = {};
      searchCriteria.criteria = [];
      return Service.Post(searchCriteria, url.search);
    };


    service.prototype = Object.create(BaseFactory.constructor.prototype);
    service.prototype.constructor = service;

    return new service();
  }]);

