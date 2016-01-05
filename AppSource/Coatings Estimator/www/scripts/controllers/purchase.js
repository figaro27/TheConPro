/**
 * @ngdoc function
 * @name estimateApp.controller:SettingsCtrl
 * @description
 * # SettingsCtrl
 * Controller of the estimateApp
 */
angular.module('estimateApp')
  .controller('PurchaseCtrl', ['$scope','$state', 'Authorization', 'IAP',
    function ($scope, $state, Authorization, IAP) {
    'use strict';

    $scope.init = function() {

    };
    $scope.testBuy = function() {
      IAP.testBuy();
    };
    $scope.buyMonthly = function() {
      IAP.buyMonthly();
    };
    $scope.buyYearly = function() {
      IAP.buyYearly();
    };

  }]);
