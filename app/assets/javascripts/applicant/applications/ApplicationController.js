ObjectModule.factory('ApplicationService', ApplicationService);
ObjectModule.controller('ApplicationController', ['$scope', 'ApplicationService', function ($scope, ApplicationService) {
    $scope.application_types = [];
    $scope.application = {};
    $scope.application.distinctive_sign = {};
    $scope.application.data_general = {};
    $scope.application.data_general.person = {};
    $scope.application.data_general.address_data = {};
    $scope.application.address_notification = {};
    $scope.application.address_notification.address_data = {};
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
            $scope.type_persons = data.type_persons;
            $scope.countries = data.countries;
            $scope.sign_types = data.sign_types;
            $scope.brand_types = data.brand_types;
        }, function (error) {

        });
    });

    $scope.saveRequest = function ($index, form_request_data) {
        $scope.submitted[$index] = true;
        var has_file = false;
        if ($scope.form_request.$valid) {
            $scope.application.data_general_attributes = $scope.application.data_general;
            $scope.application.data_general_attributes.person_attributes = $scope.application.data_general.person;
            $scope.application.data_general_attributes.address_data_attributes = $scope.application.data_general.address_data;
            $scope.application.address_notification_attributes = $scope.application.address_notification;
            $scope.application.address_notification_attributes.address_data_attributes = $scope.application.address_notification.address_data;

            if ($scope.application.distinctive_sign.used_previous) {
                $scope.application.distinctive_sign.establishment_location_attributes = $scope.application.distinctive_sign.establishment_location;
                $scope.application.distinctive_sign.establishment_location_attributes.address_data_attributes = $scope.application.distinctive_sign.establishment_location.address_data;
            }

            var data = $scope.application;

            /*if ($scope.application.distinctive_sign.brand_type_id != $scope.nominative_brand_type) {
                has_file = true;
                //Se manda un archivo
                data = new FormData();
            }*/
            console.log(data);
            ApplicationService.create(data, has_file).then(function (response) {
                if (response.data.status) {
                    swal({
                        title: "Exito",
                        text: "La solicitud fue creada exitosamente",
                        type: 'success',
                        allowOutsideClick: false,
                        allowEscapeKey: false
                    }).then(function () {
                        location.href = "/";
                    }, function (dismmiss) {

                    })
                }
            }, function (error) {
                console.log(error)
            });
        }
    };

    $scope.previousSection = function ($index, form_request_data) {
        $scope.steps[$index].disabled = true;
        $scope.steps[$index - 1].disabled = false;
    }
    $scope.nextSection = function ($index, form_request_data) {
        $scope.submitted[$index] = true;
        if (form_request_data.$valid) {
            $scope.steps[$index].disabled = true;
            $scope.steps[$index + 1].disabled = false;
        }

        /*var nextStep = false;
        if (nextStep) {
            if($scope.event_id != null){
                $scope.tabs[$index].disabled = true;
                $scope.tabs[$index + 1].disabled = false;
            }
            else{
                $scope.tabs_multiple_events[$index].disabled = true;
                $scope.tabs_multiple_events[$index + 1].disabled = false;
                if($scope.tabs_multiple_events_ticket_exist.length-1 > $index){
                    $scope.tabs_multiple_events_ticket_exist[$index].disabled = true;
                    $scope.tabs_multiple_events_ticket_exist[$index + 1].disabled = false;
                }
            }
            $scope.currentIndexWizard = $index + 1;
        } else {
            $scope.invalid_form[$index] = true;
        }*/
    }

    $scope.$watch('application.application_type_id', function (newVal) {
        if (newVal != undefined) {
            angular.forEach($scope.application_types, function (application_type) {
                if (application_type.id == newVal) {
                    $scope.steps = JSON.parse(application_type.steps);
                    $('.header-searchbox').on('click', function (ev) {
                        ev.stopPropagation();
                    });
                    $('.header-searchbox').on('keydown', function (ev) {
                        ev.stopPropagation();
                    });
                }
            });
        }
    });

    $scope.$watch('data.same_address_notification', function (newVal) {
        if (newVal) {
            $scope.application.address_notification.address_data = $scope.application.data_general.address_data;
        }
    })
}]);