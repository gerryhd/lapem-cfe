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
            $scope.application_types = data.application_types;
            $scope.countries = data.countries;
            $scope.sign_types = data.sign_types;
            $scope.brand_types = data.brand_types;
            $scope.type_requests = data.type_requests;
            $scope.design_types = data.design_types;
            $scope.copyright_branches = data.copyright_branches;
            $scope.derivation_types = data.derivation_types;

            $scope.reset();
        }, function (error) {
        });


    });

    $scope.saveRequest = function ($index, form_request_data) {
        $scope.submitted[$index] = true;
        var has_file = false;

        if ($scope.form_request.$valid) {

        }
    };



    $scope.reset = function () {
        angular.copy($scope.application_original, $scope.application);
    };
    $scope.submitForm = function(){
        console.log(findDiff($scope.application, $scope.application_original));
        debugger;
        // do w/e to save, then update the user to match the edit
    };

    function findDiff(original, edited){
        var diff = {};
        for(var key in original){
            if(original[key] !== edited[key]) {
                diff[key] = edited[key];
            }
        }
        return diff;
    }

    $scope.$watch('application.application_type_id', function (newVal) {
        console.log('iran');
        if (newVal != undefined) {
            angular.forEach($scope.application_types, function (application_type) {
                if (application_type.id == newVal) {
                    $scope.steps = JSON.parse(application_type.steps);
                    setTimeout(function () {
                        $('.header-search-box').on('click', function (ev) {
                            ev.stopPropagation();
                        });
                        $('.header-search-box').on('keydown', function (ev) {
                            ev.stopPropagation();
                        });
                    }, 2000);
                }
            });
        }
    });
}]);