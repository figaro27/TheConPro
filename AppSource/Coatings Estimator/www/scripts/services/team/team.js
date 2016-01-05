angular.module('estimateApp')
  .service('Team', ['$q', 'Service', 'TeamDetail', function ($q, Service, TeamDetail) {
    'use strict';
    var service = this;

    var url = {
      search: 'api/v1/team/search',
      add: 'api/v1/team',
      update: 'api/v1/team',
      ownership: 'api/v1/team/ownership',
      membership: 'api/v1/team/membership'
    };

    service.GetMembership = function () {
      return Service.Post({}, url.membership);
    };

    service.GetOwnership = function () {
      return Service.Post({}, url.ownership);
    };

    service.Get = function (id) {
      var searchCriteria = {},
        criteria = [];
      criteria.push({'id': id});
      searchCriteria.criteria = criteria;
      return Service.Post(searchCriteria, url.search);
    };

    service.GetAll = function () {
      var searchCriteria = {},
        criteria = [];
      searchCriteria.criteria = criteria;
      return Service.Post(searchCriteria, url.search);
    };

    service.Add = function (model) {
      var response = $q.defer();
      Service.Post(model, url.add)
        .then(function (result) {
          var saves = [];
          saves.push(buildSaveDetails(result.id, model.members));
          $q.all(saves)
            .then(function (saveresult) {
              return response.resolve(saveresult);
            },
            function (error) {
              return response.reject(error);
            });
        },
        function (error) {
          return response.reject(error);
        });
      return response.promise;
    };

    service.Update = function (model) {
      var response = $q.defer();

      if(model.canEdit){
        Service.Put(model, url.update)
          .then(function (result) {
            var saves = [];

            saves.push(buildSaveDetails(result.id, model.members));
            $q.all(saves)
              .then(function (saveresult) {
                return response.resolve(saveresult);
              },
              function (error) {
                return response.reject(error);
              });

          },
          function (error) {
            return response.reject(error);
          });
      }
      else{
        var saves = [];
        saves.push(buildSaveDetails(model.id, model.members));
        $q.all(saves)
          .then(function (saveresult) {
            return response.resolve(saveresult);
          },
          function (error) {
            return response.reject(error);
          });
      }

      return response.promise;
    };

    function buildSaveDetails(id, detail) {
      var response = $q.defer();
      var innerResponse = [],
        i = 0;
      var adds = _.where(detail, {'added': true});
      var newEmail = [];
      _.each(adds, function (member) {
        var m = {
          email: member.email
        };
        newEmail.push(m);
      });
      var newDetail =
        {
          'teamid': id,
          'members': newEmail
        };
      if(newEmail.length > 0){
        i = i + 1;
        innerResponse.push(TeamDetail.Add(newDetail));
      }


      var deletes = _.where(detail, {'visible': false});
      _.each(deletes, function (member) {
        i = i + 1;
        innerResponse.push(TeamDetail.Remove(member.id));
      });



      if (i >= 0) {
        return response.resolve(innerResponse);
      }
      return response.promise;
    }

    return service;
  }]);
