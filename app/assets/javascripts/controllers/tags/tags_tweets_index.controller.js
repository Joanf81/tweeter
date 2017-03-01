app.controller('TagsTweetsIndexController', function($scope, $routeParams, tagsService, tweetsService) {

    var load_tweets = function() {
        tagsService.indexTagTweets($routeParams.idTag,
            // success:
            function (response) {
                $scope.tweets = response.data;
            },
            // error:
            function () {
                alert("An unexpected error has occurred while indexing the tweets of the tag.");
                window.location = "/";
            }
        );
    }

    $scope.delete_tweet = function(id_tweet) {
        var num_tweets = $scope.tweets.length;
        tweetsService.deleteTweets(id_tweet,
            // success:
            function() {

                if (num_tweets == 1) {
                    window.location = "#!/tags/index";
                } else {
                    load_tweets();
                }
            },
            // error:
            function() {
                alert("An unexpected error has occurred while deleting the tweet.");
                window.location = "/";
            }
        );
    };

    load_tweets();
});