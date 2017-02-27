app.controller('TweetsNewController', function($scope, usersService, tweetsService, angularRoutes) {

    usersService.indexUsers(
        // success:
        function(response) {
            $scope.users = response.data;
        },
        // error:
        function() {
            alert("An unexpected error has occurred.");
            window.location = "/";
        }
    );

    $scope.tweets_create = function() {

        var validation_error = false;

        if ($('#tweettext').attr("jfb-validate-is-alert") == "true") {

            $('#tweettext').blur();
            validation_error = true;
        }

        if ($("#url").attr("jfb-validate-is-alert") == "true") {

            $("#url").blur();
            validation_error = true;
        }

        if (validation_error == true) {
            alert("Some validation errors founded. Fix it before send the form.");

        } else {

            var formData = {
                type: $scope.contentType,
                user_id: $scope.author,
                text: $scope.tweettext,
                url: $scope.url
            }

            tweetsService.createTweets(formData,

                // Success:
                function() {
                    window.location = '#!' + angularRoutes.tweets_index;
                },
                // Error:
                function() {
                    alert("It exists some errors in the form.");
                });
        }
    };
});