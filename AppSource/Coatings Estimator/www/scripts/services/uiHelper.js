

angular.module('estimateApp')
    .service('uiHelper', function Account($rootScope, $ionicLoading, $ionicPopup) {
    	'use strict';
    	var service = this;

    	service.showLoadingWheel = function() {
            $ionicLoading.show({
                template: 'Loading...'
            });
    	};

        service.hideLoadingWheel = function() {
            $ionicLoading.hide();
        }

        service.showRatePrompt = function($scope) {

        };

        service.showNoty = function(msg, type) {

            var n = noty({
                text        : msg,
                type        : typeof(type) == 'undefined' ? 'success' : type,
                dismissQueue: true,
                timeout     : 2000,
                closeWith   : ['click'],
                layout      : 'topRight',
                theme       : 'someOtherTheme',
                maxVisible  : 5
            });
        }

    	return service;
    });