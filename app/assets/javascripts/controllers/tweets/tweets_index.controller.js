app.controller('TweetsIndexController', function($scope, tweetsService) {

    tweetsService.indexTweets(
        // success:
        function(response) {
            $scope.tweets = response.data;
        },
        // error:
        function() {
            alert("An unexpected error has occurred.");
            window.location = "/";
        }
    );
});