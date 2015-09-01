var app;

app = angular.module('estimateApp', [
  'ui.router',
  'ngCordova',
  'ui.bootstrap',
  'restangular'
]);

// add our constants
app.constant('_', window._);

app.constant('AccessLevels', {
  anon: 'anon',
  user: 'user',
  administrator: 'administrator',
  subscriber: 'subscriber',
  concreteprotector: 'concreteprotector'
});

app.config(['$stateProvider',
  '$urlRouterProvider',
  'RestangularProvider',
  '$locationProvider',
  '$httpProvider',
  'AccessLevels',
  'Config',
  'datepickerConfig',
  function ($stateProvider, $urlRouterProvider, RestangularProvider, $locationProvider, $httpProvider, AccessLevels, Config, datepickerConfig) {
    'use strict';
    $urlRouterProvider.otherwise('/login');

    datepickerConfig.showWeeks = false;

    var index = {
      name: 'index',
      url: '/',
      views: {
        '@': {
          templateUrl: 'views/common/_layout.html'
        },
        'content@index': {
          templateUrl: 'views/common/navigation.html',
          controller: 'MainCtrl'
        },
        'header@index': {
          controller: 'HeaderCtrl',
          templateUrl: 'views/common/_header.html'
        }
      },
      data: {
        access: [AccessLevels.user],
        pageTitle: ''

      }
    };


    var login = {
      name: 'index.login',
      url: 'login',
      views: {
        'content@index': {
          controller: 'LoginCtrl',
          templateUrl: 'views/account/login.html'
        },
        'header@index': {
          controller: 'HeaderCtrl',
          templateUrl: 'views/common/_headerTitleOnly.html'
        }
      },
      data: {
        access: [AccessLevels.anon],
        pageTitle: 'Login'
      }
    };
    var register = {
      name: 'index.register',

      url: 'register',
      views: {
        'content@index': {
          controller: 'RegisterCtrl',
          templateUrl: 'views/account/register.html'
        },
        'header@index': {
          controller: 'HeaderCtrl',
          templateUrl: 'views/common/_headerTitleOnly.html'
        }
      },
      data: {
        access: [AccessLevels.anon],
        pageTitle: 'Register'
      }
    };
    var changepassword = {
      name: 'index.changepassword',

      url: 'changepassword',
      views: {
        'content@index': {
          controller: 'ChangePasswordCtrl',
          templateUrl: 'views/account/changepassword.html'
        }
      },
      data: {
        access: [AccessLevels.user],
        pageTitle: 'Change Password'
      }
    };
    var feedback = {
      name: 'index.feedback',

      url: 'feedback',
      views: {
        'content@index': {
          controller: 'FeedbackCtrl',
          templateUrl: 'views/account/feedback.html'
        }
      },
      data: {
        access: [AccessLevels.user],
        pageTitle: 'Feedback'
      }
    };
    var forgotpassword = {
      name: 'index.forgotpassword',

      url: 'forgotpassword',
      views: {
        'content@index': {
          controller: 'RegisterCtrl',
          templateUrl: 'views/account/forgotpassword.html'
        },
        'header@index': {
          controller: 'HeaderCtrl',
          templateUrl: 'views/common/_headerTitleOnly.html'
        }
      },
      data: {
        access: [AccessLevels.anon],
        pageTitle: 'Forgot Password'
      }
    };

    var leads = {
      name: 'index.leads',
      url: 'leads/:status',
      views: {
        'content@index': {
          controller: 'LeadsCtrl',
          templateUrl: 'views/lead/leads.html'
        }
      },
      data: {
        access: [AccessLevels.user],
        pageTitle: 'Leads'
      }
    };

    var lead = {
      name: 'index.lead',
      url: 'lead/:id',
      views: {
        'content@index': {
          controller: 'LeadCtrl',
          templateUrl: 'views/lead/lead.html'
        }
      },
      data: {
        access: [AccessLevels.user],
        pageTitle: 'Lead'
      }
    };
    var newLead = {
      name: 'index.newlead',
      url: 'newlead',
      views: {
        'content@index': {
          controller: 'NewLeadCtrl',
          templateUrl: 'views/lead/newlead.html'
        }
      },
      data: {
        access: [AccessLevels.user],
        pageTitle: 'New Lead'
      }
    };

    var project = {
      name: 'index.project',
      url: 'project/:leadid/:projectid',

      views: {
        'content@index': {
          controller: 'ProjectCtrl',
          templateUrl: 'views/lead/project.html'
        }
      },
      data: {
        access: [AccessLevels.user],
        pageTitle: 'Project'
      }
    };

    var projects = {
      name: 'index.projects',
      url: 'projects/:status/:time',
      views: {
        'content@index': {
          controller: 'ProjectsCtrl',
          templateUrl: 'views/lead/projects.html'
        }
      },
      data: {
        access: [AccessLevels.user],
        pageTitle: 'Projects'
      }
    };

    var settings = {
      name: 'index.settings',

      url: 'settings',
      views: {
        'content@index': {
          controller: 'SettingsCtrl',
          templateUrl: 'views/common/settings.html'
        }
      },
      data: {
        access: [AccessLevels.user],
        pageTitle: 'Settings'
      }
    };

    var systems = {
      name: 'index.systems',

      url: 'systems',
      resolve: {
        models: ['System', function (Service) {
          return Service.GetAll({'type': 'maintain'});
        }]
      },
      views: {
        'content@index': {
          templateUrl: 'views/common/list.html',
          controller: ['$scope', '$state', 'models', function ($scope, $state, models) {
            $scope.Models = models;
            $scope.goto = function (id) {
              $state.go(system.name, {id: id});
            };
            $scope.newmodel = newsystem.name;
          }]
        }
      },
      data: {
        access: [AccessLevels.concreteprotector, AccessLevels.administrator, AccessLevels.subscriber],
        pageTitle: 'Systems'
      }
    };
    var newsystem = {
      name: 'index.newsystem',
      url: 'system/',

      views: {
        'content@index': {
          controller: 'SystemCtrl',
          templateUrl: 'views/system/system.html'
        }
      },
      data: {
        access: [AccessLevels.concreteprotector, AccessLevels.administrator, AccessLevels.subscriber],
        pageTitle: 'New System'
      }
    };
    var system = {
      name: 'index.system',
      url: 'system/:id',

      views: {
        'content@index': {
          controller: 'SystemCtrl',
          templateUrl: 'views/system/system.html'
        }
      },
      data: {
        access: [AccessLevels.concreteprotector, AccessLevels.administrator],
        pageTitle: 'Edit System'
      }
    };

    var colors = {
      name: 'index.colors',

      url: 'colors',
      resolve: {
        models: ['Color', function (Service) {
          return Service.Get();
        }]
      },
      views: {
        'content@index': {
          templateUrl: 'views/common/list.html',
          controller: ['$scope', '$state', 'models', function ($scope, $state, models) {
            $scope.Models = models;
            $scope.goto = function (id) {
              $state.go(color.name, {id: id});
            };
            $scope.newmodel = newcolor.name;
          }]
        }
      },
      data: {
        access: [AccessLevels.concreteprotector, AccessLevels.administrator, AccessLevels.subscriber],
        pageTitle: 'Colors'
      }
    };
    var newcolor = {
      name: 'index.newcolor',
      url: 'color/',

      views: {
        'content@index': {
          controller: 'ColorCtrl',
          templateUrl: 'views/system/color.html'
        }
      },
      data: {
        access: [AccessLevels.concreteprotector, AccessLevels.administrator],
        pageTitle: 'New Color'
      }
    };
    var color = {
      name: 'index.color',
      url: 'color/:id',

      views: {
        'content@index': {
          controller: 'ColorCtrl',
          templateUrl: 'views/system/color.html'
        }
      },
      data: {
        access: [AccessLevels.concreteprotector, AccessLevels.administrator],
        pageTitle: 'Edit Color'
      }
    };

    var ingredients = {
      name: 'index.ingredients',

      url: 'ingredients',

      resolve: {
        models: ['Ingredient', function (Service) {
          return Service.Get();
        }]
      },
      views: {
        'content@index': {
          templateUrl: 'views/common/list.html',
          controller: ['$scope', '$state', 'models', function ($scope, $state, models) {
            $scope.Models = models;
            $scope.goto = function (id) {
              $state.go(ingredient.name, {id: id});
            };
            $scope.newmodel = newingredient.name;
          }]
        }
      },
      data: {
        access: [AccessLevels.concreteprotector, AccessLevels.administrator],
        pageTitle: 'Ingredients'
      }
    };
    var newingredient = {
      name: 'index.newingredient',
      url: 'ingredient/',

      views: {
        'content@index': {
          controller: 'IngredientCtrl',
          templateUrl: 'views/system/ingredient.html'
        }
      },
      data: {
        access: [AccessLevels.concreteprotector, AccessLevels.administrator],
        pageTitle: 'New Ingredient'
      }
    };
    var ingredient = {
      name: 'index.ingredient',
      url: 'ingredient/:id',

      views: {
        'content@index': {
          controller: 'IngredientCtrl',
          templateUrl: 'views/system/ingredient.html'
        }
      },
      data: {
        access: [AccessLevels.concreteprotector, AccessLevels.administrator],
        pageTitle: 'Edit Ingredient'
      }
    };

    var patterns = {
      name: 'index.patterns',

      url: 'patterns',
      resolve: {
        models: ['Pattern', function (Service) {
          return Service.Get();
        }]
      },
      views: {
        'content@index': {
          templateUrl: 'views/common/list.html',
          controller: ['$scope', '$state', 'models', function ($scope, $state, models) {
            $scope.Models = models;
            $scope.goto = function (id) {
              $state.go(pattern.name, {id: id});
            };
            $scope.newmodel = newpattern.name;
          }]
        }
      },
      data: {
        access: [AccessLevels.concreteprotector, AccessLevels.administrator],
        pageTitle: 'Patterns'
      }
    };
    var newpattern = {
      name: 'index.newpattern',
      url: 'pattern/',

      views: {
        'content@index': {
          controller: 'PatternCtrl',
          templateUrl: 'views/system/pattern.html'
        }
      },
      data: {
        access: [AccessLevels.concreteprotector, AccessLevels.administrator],
        pageTitle: 'New Pattern'
      }
    };
    var pattern = {
      name: 'index.pattern',
      url: 'pattern/:id',

      views: {
        'content@index': {
          controller: 'PatternCtrl',
          templateUrl: 'views/system/pattern.html'
        }
      },
      data: {
        access: [AccessLevels.concreteprotector, AccessLevels.administrator],
        pageTitle: 'Edit Pattern'
      }
    };

    var myTeamOwnership = {
      name: 'index.ownership',

      url: 'ownership',
      resolve: {
        models: ['Team', function (Service) {
          return Service.GetOwnership();
        }]
      },
      views: {
        'content@index': {
          templateUrl: 'views/team/teams.html',
          controller: ['$scope', '$state', 'models', function ($scope, $state, models) {
            $scope.Models = models;
            $scope.goto = function (id) {
              $state.go('index.team', {id: id});
            };
          }]
        }
      },

      data: {
        access: [AccessLevels.concreteprotector, AccessLevels.administrator, AccessLevels.subscriber],
        pageTitle: 'My Teams'
      }
    };

    var myTeamMembership = {
      name: 'index.membership',

      url: 'membership',
      resolve: {
        models: ['Team', function (Service) {
          return Service.GetMembership();
        }]
      },
      views: {
        'content@index': {
          templateUrl: 'views/team/teams.html',
          controller: ['$scope', '$state', 'models', function ($scope, $state, models) {
            $scope.Models = models;
            $scope.goto = function (id) {
              $state.go('index.team', {id: id});
            };
          }]
        }
      },
      data: {
        access: [AccessLevels.concreteprotector, AccessLevels.administrator, AccessLevels.subscriber],
        pageTitle: 'Team Membership'
      }
    };

    var newteam = {
      name: 'index.newteam',
      url: 'pattern/',

      views: {
        'content@index': {
          controller: 'TeamCtrl',
          templateUrl: 'views/team/team.html'
        }
      },
      data: {
        access: [AccessLevels.concreteprotector, AccessLevels.subscriber, AccessLevels.administrator],
        pageTitle: 'New Team'
      }
    };

    var team = {
      name: 'index.team',
      url: 'team/:id',

      views: {
        'content@index': {
          controller: 'TeamCtrl',
          templateUrl: 'views/team/team.html'
        }
      },
      data: {
        access: [AccessLevels.concreteprotector, AccessLevels.subscriber, AccessLevels.administrator],
        pageTitle: 'Edit Team'
      }
    };

    $stateProvider.state(index);

    $stateProvider.state(leads);
    $stateProvider.state(lead);
    $stateProvider.state(newLead);

    $stateProvider.state(project);
    $stateProvider.state(projects);

    $stateProvider.state(login);
    $stateProvider.state(changepassword);
    $stateProvider.state(forgotpassword);
    $stateProvider.state(register);

    $stateProvider.state(settings);
    $stateProvider.state(feedback);
    $stateProvider.state(systems);
    $stateProvider.state(newsystem);
    $stateProvider.state(system);

    $stateProvider.state(colors);
    $stateProvider.state(newcolor);
    $stateProvider.state(color);

    $stateProvider.state(ingredients);
    $stateProvider.state(newingredient);
    $stateProvider.state(ingredient);

    $stateProvider.state(patterns);
    $stateProvider.state(newpattern);
    $stateProvider.state(pattern);

    $stateProvider.state(myTeamMembership);
    $stateProvider.state(myTeamOwnership);
    $stateProvider.state(newteam);
    $stateProvider.state(team);

    RestangularProvider.setDefaultHeaders({'Concrete-Access': 'Yes'});
    RestangularProvider.setBaseUrl(Config.WebServiceEndpoint);
    RestangularProvider.setDefaultHttpFields({
      withCredentials: true
    });
    $httpProvider.interceptors.push('HttpInterceptor');


  }]).run(['$rootScope', '$state', '$stateParams', 'Authorization', 'Config',
  function ($rootScope, $state, $stateParams, Authorization, Config) {
    'use strict';


    //$rootScope.$on('$stateChangeStart', function (event, toState, toParams, fromState, fromParams) {
    $rootScope.$on('$stateChangeStart', function (event, toState) {

      Authorization.CheckToken();

      if (!Authorization.IsAuthorized(toState.data.access)) {
        event.preventDefault();
        $state.go('index.login');
      }
      var pageTitle = toState.data.pageTitle;
      $rootScope.$broadcast(Config.SetTitleEvent, pageTitle);
    });

    //https://github.com/angular-ui/ui-router/issues/92
    $rootScope.$on('$stateChangeSuccess', function (event, toState, toParams, fromState, fromParams) {
      // to be used for back button //won't work when page is reloaded.
      $rootScope.appTargetStateName = fromState.name;
      $rootScope.appTargetStateParams = fromParams;
    });
    //back button function called from back button's ng-click="back()"
    $rootScope.back = function () {
      if ($rootScope.appTargetStateName) {
        $state.go($rootScope.appTargetStateName, $rootScope.appTargetStateParams);
      }

    };
    //

    $rootScope.$state = $state;
    $rootScope.$stateParams = $stateParams;

  }]);
