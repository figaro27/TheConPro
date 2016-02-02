angular.module('estimateApp')
    .controller('NewContractCtrl', [
        '$rootScope', '$scope', '$q', 'project','Contract','ContractTemplate','Storage', '$stateParams', 'Contract', 'System', 'Project', '$compile', '$timeout', '$http',
        function ($rootScope, $scope, $q, project, Contract, ContractTemplate, Storage, $stateParams, Service, System, Project, $compile, $timeout, $http) {
            "use strict";

            $scope.init = function() {
              $scope.isNew = false;
              $scope.Project ={};
              $scope.model = {};
              $scope.model.showPreview = false;
              $scope.model.discount = 0.0;
              $scope.projectid = $stateParams.projectid;


                ContractTemplate.Search([],{storageType: 'contracttemplatelayout', searchType: 'use'})
                    .then(function(contractTemplates){
                            $scope.ContractTemplates = contractTemplates;
                    }, function(error){
                       var e = 'do something with the error ' + error;
                    });

                Contract.ProjectDetails(project)
                    .then(function(results){
                        $scope.Project = results;
                    });

                $scope.TemplateChange = function(id) {
                    $scope.selectedTemplate =_.where($scope.ContractTemplates,{id:id})[0];
                    var criteria = [];
                    criteria.push({'id': $scope.selectedTemplate.layoutid});
                    criteria.push({fid: $scope.selectedTemplate.id});

                    var searches = [];
                    searches.push(Storage.Search([{'id': $scope.selectedTemplate.layoutid}],{storageType:'contracttemplatelayout', searchType : 'use', populate : false}));
                    searches.push(Storage.Search([{'fid': $scope.selectedTemplate.id}],{storageType:'contracttemplateheader', searchType : 'use', populate : false}))
                    searches.push(Storage.Search([{'fid': $scope.selectedTemplate.id}],{storageType:'contracttemplatefooter', searchType : 'use', populate : false}))
                    searches.push(Storage.Search([{'fid': $scope.selectedTemplate.id}],{storageType:'contracttemplateterm', searchType : 'use', populate : false}))

                    $q.all(searches)
                        .then(function(storage){
                            var storages = _.flatten(storage);
                            var p = storages;
                            $scope.Layout = storage
                        }, function(error){
                            var e = 'do something with the error ' + error;
                        });
                };

              /*
                Load project details...
               */
              //$scope.loadLeadAndAddress();
              //$scope.loadProjectDetail();
            };

          $scope.loadLeadAndAddress = function() {
            var promises = [];
            var hints = {
              searchType: 'use',
              populate: true
            };

            promises.push(Lead.Get($scope.leadid, hints));
            var addresscriteria = [{'personid': $scope.leadid}];

            promises.push(Address.Search(addresscriteria));
            if ($scope.isNew === false) {
              promises.push(Project.Search([{id: $scope.projectid}]));
            }

            $q.all(promises)
              .then(function (promiseResults) {
                populateLead(promiseResults[0][0]);
                $scope.Systems = promiseResults[1];
                $scope.Addresses = promiseResults[2];
                if (promiseResults.length > 3) {
                  populateProject(promiseResults[3][0]);
                }
                else {
                  populateProject({
                    leadid: $scope.Lead.id
                  });
                }
              }, function (error) {
                $scope.errors = error;
              });

            function populateLead(model) {
              $scope.Lead = model;
            }

            function ensureProject(project){
              var response = $q.defer();
              if (project.id && project.id.length === 36) {
                response.resolve(project);
              }
              else{
                saveProject(project)
                  .then(function(result){
                    return response.resolve(result);
                  }, function(error){
                    response.reject(error);
                  });
              }
              return response.promise;
            }
          };

          $scope.loadProjectDetail = function() {
            var promises = [];
            var hints = {
              searchType: 'use',
              populate: true
            };
            var searchType = {
              'type': 'use',
              'populate': ['systemdetail', 'ingredient']
            };

            promises.push(Project.Search([{id: $scope.projectid}]));
            //promises.push(Lead.Get($scope.leadid, hints));
            promises.push(System.GetAll(searchType));
            //var addresscriteria = [{'personid': $scope.leadid}];

            /*
            promises.push(Address.Search(addresscriteria));

            if ($scope.isNew === false) {
              promises.push(Project.Search([{id: $scope.projectid}]));
            }
            */

            $q.all(promises)
              .then(function (promiseResults) {
                //populateLead(promiseResults[0][0]);
                $scope.Systems = promiseResults[1];
                $scope.Addresses = promiseResults[2];
                if (promiseResults.length > 3) {
                  populateProject(promiseResults[3][0]);
                }
                else {
                  populateProject({
                    leadid: $scope.Lead.id
                  });
                }
              }, function (error) {
                $scope.errors = error;
              });

            function populateLead(model) {
              $scope.Lead = model;
            }

            function ensureProject(project){
              var response = $q.defer();
              if (project.id && project.id.length === 36) {
                response.resolve(project);
              }
              else{
                saveProject(project)
                  .then(function(result){
                    return response.resolve(result);
                  }, function(error){
                    response.reject(error);
                  });
              }
              return response.promise;
            }
          }

          $scope.validate = function(model, errors) {
            model.projectid = $scope.projectid;
            model.version = 1;
            model.signatureid = $scope.selectedTemplate.id;
            model.signaturedate = new Date();
            model.templateid = $scope.selectedTemplate.id;
            model.termid = $scope.selectedTemplate.id;
            model.headerid = $scope.selectedTemplate.id;
            model.footerid = $scope.selectedTemplate.id;
            model.price = 100;
            //model.discount = "";
            model.status = "00";
          };

          $scope.save = function() {
            $scope.saving = true;
            var errors = [];
            var model = $scope.model;
            model.errors = [];

            $scope.validate(model, errors);

            if (errors.length > 0) {
              model.errors = errors;
              model.error = errors.join(', ');
              return model.error;
            }

            model.error = [];
            model.errors = [];

            if ($scope.isNew) {
              Service.Update(model)
                .then(function (result) {
                  $scope.saving = false;
                  $rootScope.back();
                },
                function (error) {
                  $scope.saving = false;
                  model.errors = error;
                  model.error = model.errors.join(', ');

                }
              );

            }
            else {
              Service.Add(model)
                .then(function (result) {
                  $scope.saving = false;
                  $rootScope.back();
                },
                function (error) {
                  $scope.saving = false;
                  model.errors = error;
                  model.error = model.errors.join(', ');

                }
              );
            }
          }
          $scope.sendTo = function() {
            var contractHtmlBody = "";
            $scope.model.showPreview = true;

            $http.get("views/lead/contract_preview.html").then( function(result) {

              $(".contract_preview").html("");

              $(".contract_preview").append($compile(result.data)($scope));

              $timeout(function() {
                var model = {
                  subject: 'Contract from ',
                  htmlBody: $(".contract_preview").html(),
                  emailTo: $scope.model.email
                };

                Service.sendContractViaEmail(model)
                  .then(function(result) {

                  },
                  function (error) {

                  });

              }, 0);


            }, function(error) {

            });

          };

        }]);
