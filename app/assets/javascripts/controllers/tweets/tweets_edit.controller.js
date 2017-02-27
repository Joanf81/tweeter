app.controller('TweetsEditController', function($scope, tweetsService, $routeParams, angularRoutes) {

    tweetsService.showTweets($routeParams.idTweet,
        //success:
        function(response) {
            $scope.tweet = response.data
        },

        //error
        function() {
            alert("An unexpected error has occurred.");
            window.location = "/";
        });

    $scope.tweets_update = function() {

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
                text: $scope.tweet.text,
                url: $scope.tweet.url
            }

            tweetsService.updateTweets($routeParams.idTweet, formData,

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