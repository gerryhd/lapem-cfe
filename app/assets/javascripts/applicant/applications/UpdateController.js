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

    $scope.nextSection = function ($index, form_request_data) {
        $scope.submitted[$index] = true;
        if (form_request_data.$valid) {
            $scope.steps[$index].disabled = true;
            $scope.steps[$index + 1].disabled = false;
        }
    };

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


            if($scope.application_original.industrial_property != undefined){
                var date = $scope.application_original.industrial_property.previous_release_date.split('-');
                $scope.application_original.industrial_property.previous_release_date = new Date(parseInt(date[0]),parseInt(date[1])-1,parseInt(date[2]));
                if($scope.application_original.industrial_property.is_applicant_invention){
                    $scope.application_original.industrial_property.is_applicant_invention = 'true';
                }
                else{
                    $scope.application_original.industrial_property.is_applicant_invention = 'false';
                }
            }
            if($scope.application_original.distinctive_sign != undefined){
                if($scope.application_original.distinctive_sign.first_date_use != undefined){
                    var date = $scope.application_original.distinctive_sign.first_date_use.split('-');
                    $scope.application_original.distinctive_sign.first_date_use = new Date(parseInt(date[0]), parseInt(date[1])-1, parseInt(date[2]));
                }
            }
            if($scope.application_original.copyright != undefined){
                if($scope.application_original.data_general.person.birth_date != undefined){
                    var date = $scope.application_original.data_general.person.birth_date.split('-');
                    $scope.application_original.data_general.person.birth_date = new Date(parseInt(date[0]), parseInt(date[1])-1, parseInt(date[2]));
                }
                if($scope.application_original.copyright.general_data_author.birth_date != undefined){
                    var date= $scope.application_original.copyright.general_data_author.birth_date.split('-');
                    $scope.application_original.copyright.general_data_author.birth_date = new Date(parseInt(date[0]), parseInt(date[1])-1, parseInt(date[2]));
                }
                if($scope.application_original.copyright.publication_date != undefined){
                    var date = $scope.application_original.copyright.publication_date.split('-');
                    $scope.application_original.copyright.publication_date = new Date(parseInt(date[0]), parseInt(date[1])-1, parseInt(date[2]));
                }
            }

            $scope.reset();
        }, function (error) {
        });


    });

    $scope.saveNewObservation = function(user_id){
        if($scope.application.new_observation){
            let new_observation = {
                user_id: user_id.toString(),
                notes: $scope.application.new_observation
            };
            $scope.application.observations_attributes = [new_observation];
            $scope.application.application_type_id = $scope.application.application_type_id.toString();
            //$scope.application.observations
            ApplicationService.update($scope.application, false).then(function (response) {
                if (response.data.status) {
                    swal({
                        title: "Éxito",
                        text: "Tu comentario fue enviado.",
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
    }

    $scope.saveRequest = function ($index, form_request_data) {
        $scope.submitted[$index] = true;
        var has_file = false;

        if ($scope.form_request.$valid) {

        }
    };

    $scope.previousSection = function ($index, form_request_data) {
        $scope.steps[$index].disabled = true;
        $scope.steps[$index - 1].disabled = false;
    };

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
            if (data.distinctive_sign.brand_type_id != $scope.nominative_brand_type && $scope.application.distinctive_sign.new_file) {
                // delete $scope.application.data_general;
                // delete $scope.application.address_notification;
                has_file = true;
                var file = $scope.application.distinctive_sign.file_sign[0].lfFile;
                // delete $scope.application.distinctive_sign.file_sign[0];
                $scope.application.distinctive_sign.file_sign = file;
                // data = ObjectToFormData({application: data});

            }
            ApplicationService.update(data, has_file).then(function (response) {
                if (response.data.status) {
                    swal({
                        title: "Exito",
                        text: "La solicitud fue actualizada exitosamente",
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

    $scope.saveIndustrialProperty = function ($index, form_request_data) {
        $scope.submitted[$index] = true;
        if ($scope.form_request.$valid) {
            $scope.application.data_general_attributes = $scope.application.data_general;
            $scope.application.data_general_attributes.address_data_attributes = $scope.application.data_general.address_data;

            $scope.application.industrial_property.data_inventor_attributes = $scope.application.industrial_property.data_inventor;
            $scope.application.industrial_property.data_inventor_attributes.address_data_attributes = $scope.application.industrial_property.data_inventor.address_data;

            $scope.application.industrial_property.data_owner_attributes = $scope.application.industrial_property.data_owner;
            $scope.application.industrial_property.data_owner_attributes.address_data_attributes = $scope.application.industrial_property.data_owner.address_data;

            ApplicationService.update($scope.application, false).then(function (response) {
                if (response.data.status) {
                    swal({
                        title: "Exito",
                        text: "La solicitud fue actualizada exitosamente",
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

    $scope.saveCopyright = function ($index,form_request_data) {
        $scope.submitted[$index] = true;
        if ($scope.form_request.$valid) {
            $scope.application.data_general_attributes = $scope.application.data_general;
            $scope.application.data_general_attributes.address_data_attributes = $scope.application.data_general.address_data;
            $scope.application.data_general_attributes.person_attributes = $scope.application.data_general.person;

            $scope.application.copyright.data_copyrights_attributes =$scope.application.copyright.data_copyrights;
            $scope.application.copyright.person_notification_attributes = $scope.application.copyright.person_notification;
            $scope.application.copyright.general_data_author_attributes = $scope.application.copyright.general_data_author;
            $scope.application.copyright.general_data_author_attributes.address_data_attributes = $scope.application.copyright.general_data_author.address_data;

            $scope.application.copyright.legal_representative_attributes = $scope.application.copyright.legal_representative;
            $scope.application.copyright.legal_representative_attributes.address_data_attributes = $scope.application.copyright.legal_representative.address_data;

            ApplicationService.update($scope.application,false).then(function (response) {
                if (response.data.status) {
                    swal({
                        title: "Exito",
                        text: "La solicitud fue actualizada exitosamente",
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


    $scope.reset = function () {
        angular.copy($scope.application_original, $scope.application);
    };
    $scope.submitForm = function(){
        console.log(findDiff($scope.application, $scope.application_original));
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