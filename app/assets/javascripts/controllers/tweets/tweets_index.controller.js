app.controller('TweetsIndexController', function($scope, tweetsService, usersService) {

    tweetsService.indexTweets(
        // success:
        function(response) {
            $scope.tweets = response.data;
            /*
            usersService.showUsers(response.data.user_id,
                // success:
                function() {
                    $scope
                },
                // error:
                function() {

                }
            );*/
        },
        // error:
        function() {
            alert("An unexpected error has occurred.");
            window.location = "/";
        }
    );
});