app.controller('UsersShowController', function($scope, $routeParams, usersService, tweetsService) {

    usersService.showUsers($routeParams.idUser,
        //success:
        function(response) {
            $scope.user = response.data;
            load_tweets();
        },

        //error:
        function() {
            alert("An unexpected error has occurred while recovering the user data.");
            window.location = "/";
        });

    var load_tweets = function() {
        usersService.indexUserTweets($routeParams.idUser,
            //success:
            function(response) {
                $scope.user.tweets = response.data;
            },

            //error:
            function() {
                alert("An unexpected error has occurred while indexing the tweets of the user.");
                window.location = "/";
            }
        );
    }

    $scope.delete_tweet = function(id_tweet) {
        tweetsService.deleteTweets(id_tweet,
            // success:
            function() {
                load_tweets();
            },
            // error:
            function() {
                alert("An unexpected error has occurred while deleting the tweet.");
                window.location = "/";
            }
        );
    };
});