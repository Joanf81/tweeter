var app = angular.module('app', ['ngRoute', 'templates', 'jfb.validate']);

app.config(function (angularRoutes, $routeProvider) {
    $routeProvider
        .when('/', {
            controller: 'IndexController',
            templateUrl: 'index.template.html'
        })

        ///////////////////////////////// USER ROUTES ////////////////////////////////////

        .when(angularRoutes.users_index, {
            controller: 'UsersIndexController',
            templateUrl: angularRoutes.templates_users + 'users_index.template.html'
        })
        .when(angularRoutes.users_show + ':idUser', {
            controller: 'UsersShowController',
            templateUrl: angularRoutes.templates_users + 'users_show.template.html'
        })
        .when(angularRoutes.users_new, {
            controller: 'UsersNewController',
            templateUrl: angularRoutes.templates_users + 'users_new.template.html'
        })
        .when(angularRoutes.users_edit + ':idUser', {
            controller: 'UsersEditController',
            templateUrl: angularRoutes.templates_users + 'users_edit.template.html'
        })
        .when(angularRoutes.users_tweets + ':idUser', {
            controller: 'UsersTweetsController',
            templateUrl: angularRoutes.templates_users + 'users_tweets.template.html'
        })

        ///////////////////////////////// TWEET ROUTES ////////////////////////////////////

        .when(angularRoutes.tweets_index, {
            controller: 'TweetsIndexController',
            templateUrl: angularRoutes.templates_tweets + 'tweets_index.template.html'
        })
        .when(angularRoutes.tweets_new, {
            controller: 'TweetsNewController',
            templateUrl: angularRoutes.templates_tweets + 'tweets_new.template.html'
        })
        .when(angularRoutes.tweets_edit + ':idTweet', {
            controller: 'TweetsEditController',
            templateUrl: angularRoutes.templates_tweets + 'tweets_edit.template.html'
        })
        .when(angularRoutes.tweets_admin_tags + ':idTweet', {
            controller: 'TweetsAdminTagsController',
            templateUrl: angularRoutes.templates_tweets + 'tweets_admin_tags.template.html'
        })

        ///////////////////////////////// TAG ROUTES ////////////////////////////////////

        .when(angularRoutes.tags_index, {
            controller: 'TagsIndexController',
            templateUrl: angularRoutes.templates_tags + 'tags_index.template.html'
        })
        .when(angularRoutes.tags_tweets + ':idTag', {
            controller: 'TagsTweetsIndexController',
            templateUrl: angularRoutes.templates_tags + 'tags_tweets_index.template.html'
        })

        .otherwise({
            redirectTo: '/'
        });
});


app.controller('mainController', function($rootScope, $location) { });