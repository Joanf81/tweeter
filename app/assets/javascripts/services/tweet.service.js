app.factory("tweetsService", function($http, apiRoutes) {

    return {
        indexTweets: function(success, error) {
            $http.get(apiRoutes.Tweets).then(success, error);
        },
        showTweets: function(tweet_id, success, error) {
            $http.get(apiRoutes.Tweets+'/'+tweet_id).then(success, error);
        },
        createTweets: function(tweet, success, error) {
            $http.post(apiRoutes.Tweets, tweet).then(success, error);
        },
        updateTweets: function(tweet_id, tweet, success, error) {
            $http.put(apiRoutes.Tweets+'/'+tweet_id, tweet).then(success, error);
        },
        deleteTweets: function(tweet_id, success, error) {
            $http.delete(apiRoutes.Tweets+'/'+tweet_id).then(success, error);
        }
    }
});