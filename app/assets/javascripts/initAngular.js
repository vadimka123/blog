'use strict';

var SITE_KEY = '6Ldw6gUTAAAAAOHKvk6PBnUtnsEO4GrH4JcRQaMe';

var app = angular.module('blog', ['ui.bootstrap', 'ngResource', 'ngSanitize', 'ui.select', 'noCAPTCHA', 'validation.match', 'angularValidator']);

$(document).on('ready page:load', function() {
    return angular.bootstrap(document.body, ['blog']);
});

app.config(['noCAPTCHAProvider',
    function (noCaptchaProvider) {
        noCaptchaProvider.setSiteKey(SITE_KEY);
        noCaptchaProvider.setTheme('dark');
    }
]);

app.config(function ($httpProvider) {
    $httpProvider.defaults.transformRequest = function(data){
        if (data === undefined) {
            return data;
        }
        return $.param(data);
    }
});

app.filter('propsFilter', function() {
    return function(items, props) {
        var out = [];
        if (angular.isArray(items)) {
            items.forEach(function(item) {
                var itemMatches = false;
                var keys = Object.keys(props);
                for (var i = 0; i < keys.length; i++) {
                    var prop = keys[i];
                    var text = props[prop].toLowerCase();
                    if (item[prop].toString().toLowerCase().indexOf(text) !== -1) {
                        itemMatches = true;
                        break;
                    }
                }
                if (itemMatches) {
                    out.push(item);
                }
            });
        } else {
            out = items;
        }
        return out;
    };
});

app.controller('newPost', function($scope) {
    $scope.someFunction = function (item, model){
        $scope.eventResult = {item: item, model: model};
    };
    $scope.musicFunction = function(item, model){
        $scope.musicResult = {item: item, model: model};
    };
    $scope.videoFunction = function(item, model) {
        $scope.videoResult = {item: item, model: model};
    };
    $scope.post = {};
    $scope.posts = [
        {type: 'Обычный пост', detail: 'Обычный пост с прикреплённой картинкой'},
        {type: 'Галлерея', detail: 'Пост, к которому можно прикреплять несколько фото'},
        {type: 'Музыкальный пост', detail: 'Пост с прикреплённой музыкой'},
        {type: 'Видео пост', detail: 'Пост с прикреплённым видео'}
    ];
    $scope.music = {};
    $scope.musics = [
        {type: 'С прикреплённой музыкой'},
        {type: 'С Iframe-кодом'}
    ];
    $scope.video = {};
    $scope.videos = [
        {type: 'С прикреплённым видео'},
        {type: 'С ссылкой на видео'},
        {type: 'Записать стрим'}
    ];
});

app.controller('validateUser', ['$scope', '$http',
    function ($scope, $http) {
        $scope.gRecaptchaResponse = '';
        $scope.$watch('gRecaptchaResponse', function () {
            $scope.expired = false;
        });
        $scope.expiredCallback = function expiredCallback() {
            $scope.expired = true;
        };
}]);

app.directive('uniqueEmail', function($http) {
    var toId;
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function(scope, elem, attr, ctrl) {
            scope.$watch(attr.ngModel, function(value) {
                if(toId) clearTimeout(toId);
                toId = setTimeout(function(){
                    $http.get('/check/' + value + '.json').success(function(data) {
                        ctrl.$setValidity('unique', data.isUnique);
                    });
                }, 200);
            })
        }
    }
});

app.directive('validFile',function(){
    return {
        restrict: 'A',
        require:'ngModel',
        link:function(scope,el,attrs,ngModel){
            el.bind('change',function(){
                scope.$apply(function(){
                    ngModel.$setViewValue(el.val());
                    ngModel.$render();
                });
            });
        }
    }
});

app.directive('validUrl', function($http) {
    var toId;
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function(scope, elem, attr, ctrl) {
            scope.$watch(attr.ngModel, function(value) {
                if(toId) clearTimeout(toId);
                toId = setTimeout(function(){
                    $http.get('/video.json?url=' + value).success(function(data) {
                        ctrl.$setValidity('url', data.isVideo);
                    });
                }, 200);
            })
        }
    }
});