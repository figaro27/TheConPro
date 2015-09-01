/**
 * @ngdoc function
 * @name estimateApp.controller:SystemCtrl
 * @description
 * # SystemCtrl
 * Controller of the estimateApp
 */
angular.module('estimateApp')
  .controller('SystemCtrl', ['$rootScope', '$state', '$scope', '$stateParams','$q', 'System','Reference', 'Ingredient','SystemDetail','Authorization','Team','SystemTeam',  function ($rootScope, $state, $scope, $stateParams, $q, System, Reference, Ingredient , SystemDetail, Authorization, Team, SystemTeam) {
    'use strict';
    function init() {
      $scope.saving = false;
      $scope.IsInRoles = function (roles) {
        return Authorization.IsInRole(roles);
      };

      $scope.System = {
        name : ''
      };

      $scope.IsNew = true;
      $scope.TeamCount = 0;
      $scope.IngredientCount = 0;

      function get(id) {
        $scope.IsNew = false;
        System.Get(id, {'type' : 'maintain'})
          .then(function (result) {
            var innerResult = result[0];
            var saleprice = 0;
            if(innerResult.saleprice){
              if(!isNaN(innerResult.saleprice)){
                saleprice = Number(innerResult.saleprice);
              }
            }
            innerResult.saleprice = saleprice;

            $scope.System = innerResult;
          },
          function (error) {
            $scope.errors = error;
          }
        );
      }

      function getSystemIngredients(id){
        var criteria = [];
        criteria.push({'systemid': id});

        SystemDetail.Search(criteria)
          .then(function (result) {
            $scope.SystemIngredients =result;
            getIngredients(result);

          }, function (error) {
            $scope.errors = error;
          });
      }

      function getSystemTeams(id){
        var criteria = [];
        criteria.push({'systemid': id});

        SystemTeam.Search(criteria)
          .then(function (result) {
            $scope.Teams =result;
            getTeams(result);

          }, function (error) {
            $scope.errors = error;
          });
      }

      if ($stateParams.id) {
        get($stateParams.id);
        getSystemIngredients($stateParams.id);
        getSystemTeams($stateParams.id);
      }
      else{
        getIngredients();
        getTeams();
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
          return;
        }

        model.ingredients = $scope.Ingredients;
        model.teams = $scope.Teams;

        model.error = [];
        model.errors = [];

        if ($stateParams.id && ($stateParams.id).length > 10) {
          System.Update(model)
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
          System.Add(model)
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

      $scope.checkIngredient = function(id){
        var primary = _.where($scope.Ingredients, {'id': id})[0];
        primary.checked = !primary.checked;
        countIngredients();
      };

      $scope.checkTeam = function(id){
        var primary = _.where($scope.Teams, {'id': id})[0];
        primary.checked = !primary.checked;
        countTeams();
      };

      function validate(model, errors) {

        if (!model || model.name === '') {
          errors.push('missing name');
        }
        if(!model.saleprice){
          errors.push('missing system price');
        }

      }

      function getIngredients(systemIngredients){
        Ingredient.Get()
          .then(function (result) {
            if(!systemIngredients){
              $scope.Ingredients =_.sortBy(result, 'name');
              return;
            }
            var innerIngredients = result;
            _.each(innerIngredients,function(ingredient){
              var ic = _.where(systemIngredients, {'ingredientid': ingredient.id})[0];
              if(ic){
                ingredient.systemdetailid = ic.id;
                ingredient.checked = true;
                ingredient.extra = ic.extra;
                ingredient.primeextra =angular.copy(ingredient.extra);
                ingredient.factor = ic.factor;
                ingredient.primefactor = angular.copy(ingredient.factor);
                ingredient.systemdetailversion = ic.version;
              }
            });
            $scope.Ingredients =_.sortBy(innerIngredients, ['checked','name']);
            countIngredients();

          }, function (error) {
            $scope.errors = error;
          });
      }

      function getTeams(systemTeam){
        Team.GetAll()
          .then(function (result) {
            if(!systemTeam){
              $scope.Teams =_.sortBy(result, 'name');
              return;
            }
            var innerTeam = result;
            _.each(innerTeam,function(team){
              var ic = _.where(systemTeam, {'teamid': team.id})[0];
              if(ic){
                team.leadteamid = ic.id;
                team.checked = true;
                team.leadteamversion = ic.version;
              }
            });
            $scope.Teams =_.sortBy(innerTeam, 'name');
            countTeams();

          }, function (error) {
            $scope.errors = error;
          });
      }

      function countIngredients(){
        var count =_.where($scope.Ingredients, {'checked' : true}).length;
        $scope.IngredientCount = count;
        return count;
      }

      function countTeams(){
        var count =_.where($scope.Teams, {'checked' : true}).length;
        $scope.TeamCount = count;
        return count;
      }

      $scope.StatusOptions = System.StatusOptions;
      $scope.FactorOptions = System.FactorOptions;

    }

    init();
  }]);
