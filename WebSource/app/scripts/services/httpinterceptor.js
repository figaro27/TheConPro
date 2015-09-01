/**
 * @ngdoc service
 * @name estimateApp.AuthInterceptor
 * @description
 * # AuthInterceptor
 * Factory in the estimateApp.
 */
angular.module('estimateApp')
  .factory('HttpInterceptor', ['$q', '$injector', '$rootScope', function ($q, $injector, $rootScope) {
    'use strict';

    var factory = this,
      config = $injector.get('Config');

    factory.request = function (request) {
      var LocalService = $injector.get('LocalService');

      var token = LocalService.Get(config.AuthTokenName);

      if (token) {
        token = angular.fromJson(token);
      }
      if (token) {
        request.headers.Authorization = 'Bearer ' + token;
      }
      return request;
    };


    factory.responseError = function (response) {
      if (response.status === 401) {
        $rootScope.$broadcast(config.Http401);
        $injector.get('$state').go('index.login');
      }

      if (response.status === 403) {
        $rootScope.$broadcast(config.Http403);
      }
      if (response.status === 500) {
        $rootScope.$broadcast(config.Http500);
      }

      return $q.reject(response);
    };

    return factory;
  }]);
