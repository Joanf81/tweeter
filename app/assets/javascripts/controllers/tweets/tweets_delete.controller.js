app.controller('TweetsDeleteController', function($routeParams,  tweetsService, angularRoutes) {

    tweetsService.deleteTweets($routeParams.idTweet,
        // success:
        function() {
            window.location = '#!' + angularRoutes.tweets_index;
        },
        // error:
        function() {
            alert("An unexpected error has occurred.");
            window.location = "/";
        }
    );
});