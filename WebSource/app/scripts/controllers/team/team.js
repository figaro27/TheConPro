/**
 * @ngdoc function
 * @name estimateApp.controller:SystemCtrl
 * @description
 * # SystemCtrl
 * Controller of the estimateApp
 */
angular.module('estimateApp')
  .controller('TeamCtrl', ['$scope','$stateParams','$rootScope','Team','TeamDetail','Reference','Authorization','Utility',
    function ($scope, $stateParams, $rootScope, Team, TeamDetail, Reference, Authorization, Utility) {
    'use strict';
    function init() {
      $scope.saving = false;
      $scope.Model = {
        name : ''
      };
      $scope.Model.members = [];

      $scope.canEdit = true;
      var isAdministrator = Authorization.IsInRole(['concreteprotector','administrator']);

      function get(id) {
        Team.Get(id)
          .then(function (result) {
            if(result[0]){
              $scope.Model = result[0];
              $scope.canEdit = Authorization.IsOwner($scope.Model.addedby);
              $scope.Model.members = [];
              getTeamDetails(result[0].id);
            }
          },
          function (error) {
            $scope.errors = error;
          }
        );
      }

      $scope.RemoveMember = function(member, index){
        //remove member

        if(member.id){
          member.visible = false;
        }
        else{
          $scope.Model.members.splice(index, 1);
        }
      };

      $scope.NewMember = function(email){
        var errors = [];
        $scope.Model.errors = [];

        if(!email || email ===''){
          $scope.Model.errors.push('blank is not a valid email');
          return;
        }

        var existing =_.where($scope.Model.members,{'email': email});
        if(existing.length > 0){
          $scope.Model.errors.push( email + ' already exists');
          return;
        }

        if(!Utility.ValidEmail(email)){
          $scope.Model.errors.push( email + ' is not a valid email');
          return;
        }

        var newMember = {
          email : email,
          visible: true,
          added: true,
          canDelete : true
        };

        $scope.Model.members.push(newMember);
        $scope.email = '';
      };

      if ($stateParams.id) {
        get($stateParams.id);
      }

      $scope.Cancel = function () {
        $rootScope.back();
      };

      $scope.Save = function (model) {
        $scope.saving = true;
        var errors = [];
        model.errors = [];

        validate(model, errors);

        if (errors.length > 0) {
          model.errors = errors;
          model.error = errors.join(', ');
          $scope.saving = false;
          return model.error;
        }
        model.error = [];
        model.errors = [];

        model.canEdit = $scope.canEdit;

        if ($stateParams.id && ($stateParams.id).length > 10) {
          Team.Update(model)
            .then(function (result) {
              $scope.saving = false;
              $rootScope.back();
            },
            function (error) {
              $scope.saving = false;
              Reference.ProcessError(error, model.errors);
            }
          );
        }
        else{
          Team.Add(model)
            .then(function (result) {
              $scope.saving = false;
              $rootScope.back();
            },
            function (error) {
              $scope.saving = false;
              Reference.ProcessError(error, model.errors);
            }
          );
        }
      };

      function validate(model, errors) {

        if (model.name === '') {
          errors.push('missing name');
        }

      }

      function getTeamDetails(id){
        var criteria = [];
        criteria.push({'teamid': id});
        var hint = {
          populate: true
        };
        TeamDetail.Search(criteria, hint)
          .then(function (result) {
            _.each(result, function(inner){
              inner.canDelete = canIDelete(inner);
              inner.visible = true;
            });
            $scope.Model.members =result;

          }, function (error) {
            $scope.errors = error;
          });
      }

      function canIDelete(teamDetail){
        // if the current user is an administrator
        if(isAdministrator){
          return true;
        }

        // if this is a new model
        if(!$scope.Model.id){
          return true;
        }

        //if this is user is the team owner
        if(Authorization.IsOwner($scope.Model.addedby)){
          return true;
        }

        //if the current user added the team detail
        if(Authorization.IsOwner(teamDetail.addedby)){
          return true;
        }

        //if the current user is the team detail member
        if(Authorization.IsOwner(teamDetail.personid)){
          return true;
        }

        return false;

      }

    }

    init();
  }]);
