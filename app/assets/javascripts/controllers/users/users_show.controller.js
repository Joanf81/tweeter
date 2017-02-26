app.controller('UsersShowController', function($scope, $routeParams, usersService) {

    usersService.showUsers($routeParams.idUser,
        //success:
        function(response) {
            $scope.user = response.data;
        },

        //error:
        function() {
            alert("An unexpected error has occurred.");
            window.location = "/";
        });
});