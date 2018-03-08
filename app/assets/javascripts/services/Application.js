ApplicationService.$inject = ['$http', 'AUTHENTICITY_TOKEN'];

function ApplicationService($http, AUTHENTICITY_TOKEN) {
    var service = {};
    var TIMEOUT = 10000;

    var URL_ROOT = "/applicant/applications";

    service.index = index;
    service.show = show;
    service.create = create;
    service.update = update;
    service.destroy = destroy;
    service.general_information = general_information;

    return service;

    function index() {
        return $http.get(URL_ROOT + '.json', {timeout: TIMEOUT}).then();
    }

    function show(id) {
        return $http.get(URL_ROOT + '/' + id, {timeout: TIMEOUT}).then();
    }

    function create(data, has_files) {
        var options = {};
        var values = {
            application: data,
            authenticity_token: AUTHENTICITY_TOKEN
        };

        if (has_files) {
            options = {
                headers: {
                    'Content-Type': undefined
                }
            };

            values = data;
            values.append('authenticity_token', AUTHENTICITY_TOKEN);
        }

        return $http.post(URL_ROOT, values, options).then();
    }

    function update(application) {
        return $http.put(URL_ROOT + '/' + application.id, {
            application: application,
            authenticity_token: AUTHENTICITY_TOKEN
        }).then();
    }

    function general_information() {
        return $http.get(URL_ROOT + '/general_information.json', {timeout: TIMEOUT}).then();
    }

    function destroy(id) {
        return $http.delete(URL_ROOT + '/' + id + '?authenticity_token=' + encodeURIComponent(AUTHENTICITY_TOKEN)).then();
    }

}