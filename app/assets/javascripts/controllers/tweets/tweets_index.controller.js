app.controller('TweetsIndexController', function($scope, tweetsService) {

    var load_tweets = function() {
        tweetsService.indexTweets(
            // success:
            function (response) {
                $scope.tweets = response.data;
            },
            // error:
            function () {
                alert("An unexpected error has occurred while indexing the tweets.");
                window.location = "/";
            }
        );
    };

    $scope.delete_tweet = function(id_tweet) {
        tweetsService.deleteTweets(id_tweet,
            // success:
            function() {
                load_tweets();
            },
            // error:
            function() {
                alert("An unexpected error has occurred while deleting the tweet..");
                window.location = "/";
            }
        );
    };

    load_tweets();
});