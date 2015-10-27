/**
 * @ngdoc service
 * @name estimateApp.IAP
 * @description
 * # Account
 * Service in the estimateApp.
 */
angular.module('estimateApp')
    .service('IAP', ['$q', '$rootScope', '$state', '$window', '$cordovaDevice', 'Config', 'Log','Account',
        function ($q, $rootScope, $state, $window, $cordovaDevice, Config, Log, Account) {
            'use strict';
          var service = this;
          $rootScope.paid = false;

          service.init = function() {
            $rootScope.showLoadingWheel();

            if (typeof(store) == "undefined") {
              $rootScope.hideLoadingWheel();
              return;
            }


            store.verbosity = store.DEBUG;

            store.register({
              id:    'paidversion_month', // id without package name!
              alias: 'paidversion_month',
              type:   store.PAID_SUBSCRIPTION
            });

            store.register({
              id:    'paidversion_year', // id without package name!
              alias: 'paidversion_year',
              type:   store.PAID_SUBSCRIPTION
            });

            store.register({
              id:    'test_dummy', // id without package name!
              alias: 'test_dummy',
              type:   store.CONSUMABLE
            });


            store.when("test_dummy").updated(function(p) {
              //alert(JSON.stringify(p));

              if (p.owned) {
                $rootScope.paid = true;
                $state.go("index");
              }
              else {
                //alert("not paid!");
              }
            });

            store.when("paidversion_year").updated(function(p) {


              if (p.owned) {
                $rootScope.paid = true;
                $state.go("index");
              }
              else {
                //alert("yearly not paid!");
              }
            });

            store.ready(function() {
              $rootScope.hideLoadingWheel();
              //alert("Store is ready now.");
            });

            store.error(function(error) {
              $rootScope.hideLoadingWheel();
              alert(JSON.stringify(error));
            });


            store.refresh();
          };
          service.testBuy = function() {
            store.order("test_dummy");
          };
          service.buyMonthly = function() {
            store.order("paidversion_month");
          };
          service.buyYearly = function() {
            store.order("paidversion_year");
          };

          return service;
        }]);
