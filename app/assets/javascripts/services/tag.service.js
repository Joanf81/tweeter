app.factory("tagsService", function($http, apiRoutes) {

    return {
        indexTags: function(success, error) {
            $http.get(apiRoutes.Tags).then(success, error);
        },
        indexTagTweets: function(tag_id, success, error) {
            $http.get(apiRoutes.Tags+'/'+tag_id+'/tweets').then(success, error);
        }
    }
});