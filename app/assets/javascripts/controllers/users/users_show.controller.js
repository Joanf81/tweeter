app.controller('UsersShowController', function($scope, $routeParams, usersService) {

    usersService.showUsers($routeParams.idUser,
        //success:
        function(response) {
            $scope.user = response.data;

            usersService.indexUserTweets($routeParams.idUser,
                //success:
                function(response) {
                    $scope.user.tweets = response.data;
                },

                //error:
                function() {
                    alert("An unexpected error has occurred.");
                    window.location = "/";
                }
            );
        },

        //error:
        function() {
            alert("An unexpected error has occurred.");
            window.location = "/";
        });
});