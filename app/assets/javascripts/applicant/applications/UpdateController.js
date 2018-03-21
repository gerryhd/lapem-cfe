ObjectModule.factory('ApplicationService', ApplicationService);
ObjectModule.controller('UpdateController',  ['$scope', 'ApplicationService', 'ObjectToFormData', function ($scope, ApplicationService, ObjectToFormData) {
    $scope.application = {};
    $scope.application.distinctive_sign = {};
    $scope.application.data_general = {};
    $scope.application.data_general.person = {};
    $scope.application.data_general.address_data = {};
    $scope.application.address_notification = {};
    $scope.application.address_notification.address_data = {};
    $scope.application.copyright = {};
    $scope.application.copyright.person_notification = {};
    $scope.application.copyright.legal_representative = {};
    $scope.application.copyright.data_copyrights = [{
        title: '',
        author: ''
    }];

    $scope.application.industrial_property = {};
    $scope.steps = [];
    $scope.submitted = [];

    $scope.data = {};

    $scope.clearCountrySearchField = function () {
        $scope.countrySearchTerm = '';
    };

    $scope.clearSignTypeSearchField = function () {
        $scope.signTypeSearch = '';
    };

    angular.element(document).ready(function () {

        ApplicationService.general_information().then(function (response) {
            var data = response.data;

            $scope.countries = data.countries;
            $scope.sign_types = data.sign_types;
            $scope.brand_types = data.brand_types;
            $scope.type_requests = data.type_requests;
            $scope.design_types = data.design_types;
            $scope.copyright_branches = data.copyright_branches;
            $scope.derivation_types = data.derivation_types;
        }, function (error) {

        });
    });

    $scope.saveRequest = function ($index, form_request_data) {
        $scope.submitted[$index] = true;
        var has_file = false;

        if ($scope.form_request.$valid) {

        }
    }
});