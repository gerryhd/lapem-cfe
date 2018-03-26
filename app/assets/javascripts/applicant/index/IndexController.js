ObjectModule.factory('ApplicationService', ApplicationService)
ObjectModule.controller('IndexController', ['$scope', 'ApplicationService', function ($scope, ApplicationService) {
    $scope.new_request = false;

    $scope.newRequest = function () {
        $scope.new_request = true;
        $scope.application = {};
        $scope.application.address_applicant = {};
        setTimeout(function () {
            $('.header-searchbox').on('keydown', function (ev) {
                ev.stopPropagation();
            });
        }, 1000)
    };

    $scope.cancelNewRequest = function () {
        $scope.new_request = false;
    };

    $scope.clearCountrySearchField = function () {
        $scope.countrySearchTerm = '';
    };

    $scope.clearSignTypeSearchField = function () {
        $scope.signTypeSearch = '';
    };

    angular.element(document).ready(function () {
        $('.header-searchbox').on('click', function (ev) {
            ev.stopPropagation();
        });
    });

    $scope.save = function () {
        if ($scope.form_request.$valid) {
            ApplicationService.create($scope.application).then(function (response) {

            }, function (error) {

            });
        }
    }

    $scope.show = function(id){
        var edit_link = $scope.url_edit.replace('id',id);
        window.location = edit_link;
    };

    $scope.delete = function (id, $index) {
        swal({
            title: 'Eliminar Registro',
            text: "¿Esta sguro que desea eliminar el registro?",
            type: "warning",
            showCancelButton: true,
            confirmButtonText: "Eliminar",
            cancelButtonText: "Cancelar",
            showLoaderOnConfirm: true,
            allowOutsideClick: false,
            allowEscapeKey: false,
            preConfirm: function () {
                return new Promise(function (resolve, reject) {
                    ApplicationService.destroy(id).then(function (response) {
                        if (response.data.status) {
                            $scope.applications.splice($index, 1);
                            resolve("Se elimino correctamente");
                        } else {
                            reject("Ocurrio un error en el servidor");
                        }
                    }, function (error) {
                        reject("Ocurrio un error en el servidor");
                    });
                })
            }
        }).then(function (confirm) {

            swal({
                title: "Exito",
                text: confirm,
                type: 'success',
                allowOutsideClick: false,
                allowEscapeKey: false
            }).then(function () {
            }, function (dismmiss) {

            })
        }, function (dismiss) {

        });
    }
}]);