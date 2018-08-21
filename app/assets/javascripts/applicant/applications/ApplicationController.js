ObjectModule.factory('ApplicationService', ApplicationService);
ObjectModule.controller('ApplicationController', ['$scope', 'ApplicationService', 'ObjectToFormData', function ($scope, ApplicationService, ObjectToFormData) {
    $scope.application_types = [];
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
            $scope.type_persons = data.type_persons;
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
            if (data.distinctive_sign.brand_type_id != $scope.nominative_brand_type) {
                delete $scope.application.data_general;
                delete $scope.application.address_notification;
                has_file = true;
                var files = $scope.application.distinctive_sign.file_sign;
                $scope.application.distinctive_sign.file_signs = [];
                angular.forEach(files, function(file){
                    $scope.application.distinctive_sign.file_signs.push(file.lfFile);

                })
                // var file = $scope.application.distinctive_sign.file_sign[0].lfFile;
                // delete $scope.application.distinctive_sign.file_sign[0];
                // $scope.application.distinctive_sign.file_sign = file;
                data = ObjectToFormData({application: data});

            }
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

    $scope.saveIndustrialProperty = function ($index, form_request_data) {
        $scope.submitted[$index] = true;
        if ($scope.form_request.$valid) {
            $scope.application.data_general_attributes = $scope.application.data_general;
            $scope.application.data_general_attributes.address_data_attributes = $scope.application.data_general.address_data;

            $scope.application.industrial_property.data_inventor_attributes = $scope.application.industrial_property.data_inventor;
            $scope.application.industrial_property.data_inventor_attributes.address_data_attributes = $scope.application.industrial_property.data_inventor.address_data;

            $scope.application.industrial_property.data_owner_attributes = $scope.application.industrial_property.data_owner;
            $scope.application.industrial_property.data_owner_attributes.address_data_attributes = $scope.application.industrial_property.data_owner.address_data;

            ApplicationService.create($scope.application, false).then(function (response) {
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

            ApplicationService.create($scope.application, false).then(function (response) {
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
    };
    $scope.nextSection = function ($index, form_request_data) {
        $scope.submitted[$index] = true;
        if (form_request_data.$valid) {
            $scope.steps[$index].disabled = true;
            $scope.steps[$index + 1].disabled = false;
        }
    };

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

    $scope.$watch('application.distinctive_sign.used_previous', function (newVal) {
        if (newVal != undefined && newVal) {
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

    $scope.$watch('data.same_address_notification', function (newVal) {
        if (newVal) {
            $scope.application.address_notification.address_data = $scope.application.data_general.address_data;
        }
    });

    $scope.$watch('data.applicant_is_inventor', function (newVal) {
        if (newVal) {
            $scope.application.industrial_property.data_inventor = $scope.application.data_general;
        }
    });

    $scope.$watch('application.copyright.titular_is_author', function (newVal) {
        if (newVal != undefined && newVal == 1) {
            var data_general = $scope.application.data_general;
            $scope.application.copyright.general_data_author = data_general.person;
            $scope.application.copyright.general_data_author.phone = data_general.phone;
            $scope.application.copyright.general_data_author.address_data = data_general.address_data;
        }
    });

    $scope.validateDataCopyright = function () {
        var last_index = $scope.application.copyright.data_copyrights.length - 1;
        var last_element = $scope.application.copyright.data_copyrights[last_index];
        if (last_element.title != "" && last_element.author != "") {
            $scope.application.copyright.data_copyrights.push({
                title: '',
                author: ''
            })
        } else {
            swal("Titulo y autor son obligatorios");
        }
    }


}]);