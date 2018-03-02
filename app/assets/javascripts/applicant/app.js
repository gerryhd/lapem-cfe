var ObjectModule = angular.module('ApplicantModule', ['ngMaterial', 'md.data.table']);

ObjectModule.controller('MenuController', function ($scope, $timeout, $mdSidenav) {

    $scope.toggleLeft = buildToggler('left');
    $scope.toggleRight = buildToggler('right');

    function buildToggler(componentId) {
        return function () {
            $mdSidenav(componentId).toggle();
        };
    }
});

ObjectModule.config(function ($provide) {
    $provide.constant('AUTHENTICITY_TOKEN', eval($('#token').val()));
});