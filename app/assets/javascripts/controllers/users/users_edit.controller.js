app.controller('UsersEditController', function($scope, usersService, angularRoutes, $routeParams) {

    usersService.showUsers($routeParams.idUser,
        //success:
        function(response) {
            $scope.user = response.data
        },

        //error
        function() {
            alert("An unexpected error has occurred while recovering the user's data.");
            window.location = "/";
        });

    $scope.users_update = function() {

        var validation_error = false;

        if ($("#username").attr("jfb-validate-is-alert") == "true") {

            $("#username").blur();
            validation_error = true;
        }

        if ($("#email").attr("jfb-validate-is-alert") == "true") {

            $("#email").blur();
            validation_error = true;
        }

        if (validation_error == true) {
            alert("Some validation errors founded. Fix it before send the form.");

        } else {

            var formData = {
                email: $scope.user.email,
                username: $scope.user.username
            }

            usersService.updateUsers($routeParams.idUser, formData,
                //success:
                function () {
                    window.location = '#!' + angularRoutes.users_show + $routeParams.idUser;
                },

                //error:
                function (errors) {
                    alert("The server raised some validation errors. Possibly the user email is duplicated.");
                });
        }
    }

});