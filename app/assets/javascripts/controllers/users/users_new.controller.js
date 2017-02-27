app.controller('UsersNewController', function($scope, usersService, angularRoutes) {

    $scope.users_create = function() {

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
                email: $scope.email,
                username: $scope.username
            }

            usersService.createUsers(formData,

                // Success:
                function() {
                    window.location = '#!' + angularRoutes.users_index;
                },
                // Error:
                function() {
                    alert("It exists some errors in the form.");
                });
        }
    };
});