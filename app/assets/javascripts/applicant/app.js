var ObjectModule = angular.module('ApplicantModule', ['ngMaterial', 'md.data.table','lfNgMdFileInput']);

ObjectModule.controller('MenuController', function ($scope, $timeout, $mdSidenav) {

    $scope.toggleLeft = buildToggler('left');
    $scope.toggleRight = buildToggler('right');

    function buildToggler(componentId) {
        return function () {
            $mdSidenav(componentId).toggle();
        };
    }
});

ObjectModule.config(function ($provide, $mdThemingProvider) {
    $provide.constant('AUTHENTICITY_TOKEN', eval($('#token').val()));

    $mdThemingProvider.theme('default')
        .primaryPalette('green')
        .accentPalette('green');
});