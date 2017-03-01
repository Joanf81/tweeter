app.controller('UsersIndexController', function($scope, usersService) {

    usersService.indexUsers(
        // success:
        function(response) {
            $scope.users = response.data;
        },
        // error:
        function() {
            alert("An unexpected error has occurred while indexing the users.");
            window.location = "/";
        }
    );
});