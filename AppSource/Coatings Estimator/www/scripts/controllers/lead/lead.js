angular.module('estimateApp')
  .controller('LeadCtrl', ['$scope', '$stateParams', '$state', '$rootScope', '$q', 'Lead', 'Authorization',
    'Reference', 'Address', 'Phone', '$window', 'Team', 'LeadTeam', 'LeadDetail', 'Project', 'Person',
    function ($scope, $stateParams, $state, $rootScope, $q, Lead, Authorization,
              Reference, Address, Phone, $window, Team, LeadTeam, LeadDetail, Project, Person) {

      'use strict';

      function init() {
        $scope.moreThanAUser=false;
        $scope.DisableAddLead = false;
        if (Authorization.IsInRole(['concreteprotector', 'subscriber', 'administrator'])) {
          $scope.moreThanAUser = true;
          $scope.DisableAddLead = true;
        }

        $scope.Model = {};
        $scope.Addresses = [];
        $scope.Phones = [];
        var searchCriteria = [{personid: $stateParams.id}],
          hints = {
            searchType: 'use',
            populate: true,
            status: status
          },
          promises = [];

        if ($stateParams.id && $stateParams.id !== '') {
          $scope.leadid = $stateParams.id;
          promises = [];

          promises.push(Lead.Get($stateParams.id, hints));
          promises.push(Address.Search(searchCriteria));
          promises.push(Phone.Search(searchCriteria));
          promises.push(Project.Search([{leadid: $stateParams.id}, {time: 'estimate'}]));
          promises.push(Project.Search([{leadid: $stateParams.id}, {time: 'current'}]));
          promises.push(Project.Search([{leadid: $stateParams.id}, {time: 'complete'}]));
          $q.all(promises)
            .then(function (promiseResults) {
              populateLead(promiseResults[0][0]);
              populateAddresses(promiseResults[1]);
              populatePhones(promiseResults[2]);

              populateEstimates(promiseResults[3]);
              populateCurrent(promiseResults[4]);
              populateComplete(promiseResults[5]);

              if ($scope.moreThanAUser === true) {
                getLeadTeams($stateParams.id);
              }


            }, function (error) {
              Reference.ProcessError(error, $scope.errors);
            });


        }

        function populateLead(model) {
          $scope.Model = model;
          $scope.ModelPrime = {};
          $scope.editingLead = false;
        }

        function populateAddresses(models) {
          $scope.Addresses = models;
          $scope.editingAddress = false;
        }

        function populatePhones(models) {
          $scope.Phones = models;
          $scope.editingPhone = false;
        }

        function populateEstimates(models) {
          $scope.Estimates = models;
        }

        function populateCurrent(models) {
          $scope.Current = models;
        }

        function populateComplete(models) {
          $scope.Complete = models;
        }


        function getLeadTeams(id) {
          $scope.editingTeams = false;
          var criteria = [];
          criteria.push({'personid': id});

          LeadTeam.Search(criteria)
            .then(function (result) {
              $scope.Teams = result;
              getTeams(result);

            }, function (error) {
              Reference.ProcessError(error, $scope.errors);
            });

        }


        function getTeams(leadTeams) {
          Team.GetAll()
            .then(function (result) {
              $scope.CurrentTeams = [];
              if (!leadTeams) {
                $scope.Teams = _.sortBy(result, 'name');
                return;
              }
              var innerTeam = result;
              _.each(innerTeam, function (team) {
                var ic = _.where(leadTeams, {'teamid': team.id})[0];
                if (ic) {
                  team.leadteamid = ic.id;
                  team.checked = true;
                  team.leadteamversion = ic.version;
                  $scope.CurrentTeams.push(team);
                }
              });
              $scope.Teams = _.sortBy(innerTeam, 'name');
              $scope.CurrentTeams = _.sortBy($scope.CurrentTeams, 'name');
              $scope.TeamCount = $scope.CurrentTeams.length;

            }, function (error) {
              Reference.ProcessError(error, $scope.errors);
            });
        }


        $scope.IsInRoles = function (roles) {
          return Authorization.IsInRole(roles);
        };


        Reference.States('us')
          .then(function (result) {
            $scope.States = result;
          }, function (error) {
            Reference.ProcessError(error, $scope.errors);
          });


        Reference.PhoneTypes()
          .then(function (result) {
            $scope.PhoneTypes = result;
          }, function (error) {
            Reference.ProcessError(error, $scope.errors);
          });

        Reference.AddressTypes()
          .then(function (result) {
            $scope.AddressTypes = result;
          }, function (error) {
            Reference.ProcessError(error, $scope.errors);
          });

        $scope.checkTeam = function (id) {
          var primary = _.where($scope.Teams, {'id': id})[0];
          primary.checked = !primary.checked;
        };

        $scope.StatusOptions = Lead.Statuses;
        $scope.BestTimeToCalLOptions = Lead.BestTimeToCalLOptions;

        $scope.EditLead = function () {
          $scope.ModelPrime = angular.copy($scope.Model);
          $scope.editingLead = true;
        };

        $scope.CancelEditLead = function () {
          $scope.Model = angular.copy($scope.ModelPrime);
          $scope.editingLead = false;
        };

        $scope.SaveLead = function (model) {
          var errors = [];
          model.Errors = [];

          validateLead(model, errors);

          if (errors.length > 0) {
            model.errors = errors;
            model.error = errors.join(', ');
            return model.error;
          }

          model.error = [];
          model.errors = [];


          promises = [];


          promises.push(Person.Update(model.person));
          promises.push(Lead.Update(model));

          if (model.detail.id) {
            promises.push(LeadDetail.Update(model.detail));
          } else {
            if (model.hasdetail) {
              var newDetail = {
                leadid: model.id,
                email: model.detail.email,
                besttimetocall: model.detail.besttimetocall,
                hearaboutus: model.detail.hearaboutus,
                howcanwehelp: model.detail.howcanwehelp
              };
              promises.push(LeadDetail.Add(newDetail));
            }
          }

          $q.all(promises)
            .then(function (success) {
              Lead.Get($stateParams.id, hints)
                .then(function (lead) {
                  populateLead(lead[0]);
                }, function (error) {
                  Reference.ProcessError(error, $scope.errors);
                });

            }, function (error) {
              Reference.ProcessError(error, $scope.errors);
            });

        };

        $scope.EditPhone = function (model, index) {
          $scope.PhoneModelIndex = index;
          $scope.PhoneModelPrime = angular.copy(model);
          $scope.PhoneModel = model;
          $scope.editingPhone = true;
        };

        $scope.NewPhone = function () {
          $scope.PhoneModel = {};
          $scope.editingPhone = true;
        };

        $scope.CancelEditPhone = function () {
          $scope.Phones[$scope.PhoneModelIndex] = angular.copy($scope.PhoneModelPrime);
          $scope.PhoneModelPrime = {};
          $scope.PhoneModel = {};
          $scope.editingPhone = false;
        };

        $scope.SavePhone = function () {
          var model = $scope.PhoneModel;
          var errors = [];
          model.Errors = [];

          validatePhone(model, errors);

          if (errors.length > 0) {
            model.errors = errors;
            model.error = errors.join(', ');
            return model.error;
          }

          model.error = [];
          model.errors = [];


          promises = [];

          if (model.id) {
            promises.push(Phone.Update(model));
          }
          else {
            var newPhone = {
              personid: $stateParams.id,
              number: model.number,
              type: model.type,
              primary: model.primary
            };
            promises.push(Phone.Add(newPhone));
          }


          $q.all(promises)
            .then(function (success) {
              promises = [];
              promises.push(Lead.Get($stateParams.id, hints));
              promises.push(Phone.Search(searchCriteria));
              $q.all(promises)
                .then(function (results) {
                  populateLead(results[0][0]);
                  populatePhones(results[1]);
                }, function (error) {
                  Reference.ProcessError(error, $scope.errors);
                });

            }, function (error) {
              Reference.ProcessError(error, $scope.errors);
            });

        };

        function validateLead(model, errors) {

          if (!model.person.firstname && !model.person.lastname && !model.person.company) {
            errors.push('first name, last name or company required');
          }
          model.hasdetail = false;

          if (model.detail.email) {
            model.hasdetail = true;
          }
          if (model.detail.besttimetocall) {
            model.hasdetail = true;
          }
          if (model.detail.hearaboutus) {
            model.hasdetail = true;
          }
          if (model.detail.howcanwehelp) {
            model.hasdetail = true;
          }

        }

        function validatePhone(model, errors) {
          if (!model.number) {
            model.number = '';
          }
          if (!model.type) {
            model.type = 'home';
          }

        }

        $scope.EditAddress = function (model, index) {
          $scope.AddressModelIndex = index;
          $scope.AddressModelPrime = angular.copy(model);
          $scope.AddressModel = model;
          $scope.editingAddress = true;
        };

        $scope.NewAddress = function () {
          $scope.AddressModel = {};
          $scope.editingAddress = true;
        };

        $scope.CancelEditAddress = function () {
          $scope.Addresses[$scope.AddressModelIndex] = angular.copy($scope.AddressModelPrime);
          //$scope.AddressModel = angular.copy($scope.AddressModelPrime);
          $scope.AddressModelPrime = {};
          $scope.AddressModel = {};
          $scope.editingAddress = false;
        };

        $scope.SaveAddress = function () {
          var model = $scope.AddressModel;
          var errors = [];
          model.Errors = [];

          validateAddress(model, errors);

          if (errors.length > 0) {
            model.errors = errors;
            model.error = errors.join(', ');
            return model.error;
          }

          model.error = [];
          model.errors = [];


          promises = [];


          if (model.id) {
            promises.push(Address.Update(model));
          } else {
            var newAddress = {
              personid: $stateParams.id,
              address1: model.address1,
              address2: model.address2,
              city: model.city,
              state: model.state,
              zip: model.zip,
              addresstype: model.addresstype,
              primary: model.primary
            };
            promises.push(Address.Add(newAddress));
          }

          $q.all(promises)
            .then(function (success) {
              Address.Search(searchCriteria)
                .then(function (addresses) {
                  populateAddresses(addresses);
                }, function (error) {
                  Reference.ProcessError(error, $scope.errors);
                });

            }, function (error) {
              Reference.ProcessError(error, $scope.errors);
            });

        };

        function validateAddress(model, errors) {
          if (!model.address1) {
            model.address1 = '';
          }
          if (!model.city) {
            model.city = '';
          }

          if (!model.state) {
            model.state = 'OH';
          }

          if (!model.zip) {
            model.zip = '';
          }

          if (!model.type) {
            model.type = 'home';
          }
        }

        $scope.Cancel = function () {
          $rootScope.back();
        };

        $scope.SaveTeams = function () {

          var saves = [];

          _.each($scope.Teams, function (team) {
            var leadTeam = {};
            if (!team.leadteamid) {
              if (team.checked === true) {
                leadTeam.personid = $stateParams.id;
                leadTeam.teamid = team.id;
                saves.push(LeadTeam.Add(leadTeam));
              }

            } else {
              if (team.checked === false) {
                saves.push(LeadTeam.Remove(team.leadteamid));
              }

            }
          });

          //saves.push(processTeams($stateParams.id, $scope.Teams));
          $q.all(saves)
            .then(function (results) {
              getLeadTeams($stateParams.id);
            }, function (error) {
              Reference.ProcessError(error, $scope.errors);
            });
        };

        $scope.CancelEditTeams = function () {
          $scope.Teams = angular.copy($scope.TeamsPrime);
          $scope.editingTeams = false;
        };

        $scope.EditTeams = function () {
          $scope.TeamsPrime = angular.copy($scope.Teams);
          $scope.editingTeams = true;
        };

        function processTeams(id, teams) {
          var response = $q.defer();
          var innerResponse = [],
            i = 0;
          _.each(teams, function (team) {
            i = i + 1;

            var leadTeam = {};
            if (!team.leadteamid) {
              if (team.checked === true) {
                leadTeam.personid = id;
                leadTeam.teamid = team.id;
                innerResponse.push(LeadTeam.Add(leadTeam));
              }

            } else {
              // These will be associations where the ingredient is not checked
              // we will remove these as they are not checked
              if (team.checked === false) {
                innerResponse.push(LeadTeam.Remove(team.leadteamid));
              }

            }
          });
          if (i === teams.length) {
            return response.resolve(innerResponse);
          }
          return response.promise;
        }

      }

      init();

    }]);
