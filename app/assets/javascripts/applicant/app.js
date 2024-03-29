var ObjectModule = angular.module('ApplicantModule', ['ngMaterial', 'md.data.table','lfNgMdFileInput','object-to-form-data']);

ObjectModule.controller('MenuController', ['$scope', '$timeout', '$mdSidenav', function ($scope, $timeout, $mdSidenav) {

    $scope.toggleLeft = buildToggler('left');
    $scope.toggleRight = buildToggler('right');

    function buildToggler(componentId) {
        return function () {
            $mdSidenav(componentId).toggle();
        };
    }
}]);

ObjectModule.config(['$provide', '$mdThemingProvider', function ($provide, $mdThemingProvider) {
    $provide.constant('AUTHENTICITY_TOKEN', eval($('#token').val()));

    $mdThemingProvider.theme('default')
        .primaryPalette('green')
        .accentPalette('green');
}]);