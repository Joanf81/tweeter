app.controller('TweetsAdminTagsController', function($scope, $routeParams, tweetsService) {

    var load_tags = function() {

        tweetsService.showTweets($routeParams.idTweet,
            // success:
            function (response) {
                $scope.tweet = response.data;
            },
            // error:
            function () {
                alert("An unexpected error has occurred while recovering the tweet's tags.");
                window.location = "/";
            }
        );
    };


    $scope.tweets_delete_tag = function(id_tag) {

        tweetsService.deleteTag($routeParams.idTweet, id_tag,
            // success:
            function() {
                load_tags();
            },
            // error:
            function() {
                alert("An unexpected error has occurred while deleting the tag.");
                window.location = "/";
            }
        );
    };

    $scope.tweets_add_tag = function() {

        if ($scope.tag != null) {

            var validation_error = false;

            if ($("#tag").attr("jfb-validate-is-alert") == "true") {

                $("#tag").blur();
                validation_error = true;
            }

            if (validation_error == true) {
                alert("Some validation errors founded. Fix it before send the form.");

            } else {

                var formData = {
                    tag: $scope.tag
                }

                tweetsService.addTag($routeParams.idTweet, formData,

                    // Success:
                    function () {
                        $scope.tag = '';
                        load_tags();
                    },
                    // Error:
                    function () {
                        alert("The server raised some validation errors.");
                    });
            }
        }
    }

    load_tags();
});