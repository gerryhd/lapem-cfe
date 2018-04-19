var loginModule = angular.module("LoginModule", ['ngMaterial']);

loginModule.config(['$mdThemingProvider', function ($mdThemingProvider) {
    $mdThemingProvider.theme('default');
}]);



loginModule.controller('LoginController', ['$scope', function ($scope) {

}]);