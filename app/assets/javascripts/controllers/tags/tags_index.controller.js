app.controller('TagsIndexController', function($scope, tagsService) {

    tagsService.indexTags(
        // success:
        function(response) {
            $scope.tags = response.data;
        },
        // error:
        function() {
            alert("An unexpected error has occurred while indexing the tags.");
            window.location = "/";
        }
    );
});