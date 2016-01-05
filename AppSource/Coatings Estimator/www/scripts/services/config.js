angular.module('estimateApp')
  .constant('Config', {
    'AuthTokenName': 'AuthToken',
    'AuthExpiration': 'AuthExpiration',
    'AuthRoles': 'AuthRoles',
    'AuthUserName': 'AuthUserName',
    'AuthId': 'AuthId',
    //'WebServiceEndpoint': 'https://artapi1.natomis.com/',
    'WebServiceEndpoint': 'http://104.239.230.5:5000/',
    'Http200': 'HTTP:200',
    'Http401': 'HTTP:401',
    'Http403': 'HTTP:403',
    'Http500': 'HTTP:500',
    'SetTitleEvent' : 'SetTitleEvent'
  });
