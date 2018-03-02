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

    return service;

    function index(params) {
        return $http.get(URL_ROOT + '.json', {timeout: TIMEOUT, params: params}).then();
    }

    function show(id) {
        return $http.get(URL_ROOT + '/' + id, {timeout: TIMEOUT}).then();
    }

    function create(application) {
        return $http.post(URL_ROOT, {
            application: application,
            authenticity_token: AUTHENTICITY_TOKEN
        }).then();
    }

    function update(application) {
        return $http.put(URL_ROOT + '/' + application.id, {
            application: application,
            authenticity_token: AUTHENTICITY_TOKEN
        }).then();
    }

    function destroy(id) {
        return $http.delete(URL_ROOT + '/' + id + '?authenticity_token=' + encodeURIComponent(AUTHENTICITY_TOKEN)).then();
    }

}