app.factory("usersService", function($http, apiRoutes) {

    return {
        indexUsers: function(success, error) {
            $http.get(apiRoutes.Users).then(success, error);
        },
        showUsers: function(id_user, success, error) {
            $http.get(apiRoutes.Users+'/'+id_user).then(success, error);
        },
        createUsers: function(user, success, error) {
            $http.post(apiRoutes.Users, user).then(success, error);
        },
        updateUsers: function(user_id, user, success, error) {
            $http.put(apiRoutes.Users+'/'+user_id, user).then(success, error);
        }
    }
});