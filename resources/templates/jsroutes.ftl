//Generisano na osnovu sablona: jsroutes.ftl
var app = angular.module('${appName?uncap_first}App.routes', ['ngRoute']);

app.config(['$routeProvider','$httpProvider', function ($routeProvider, $httpProvider) {
    $routeProvider
        .when('/',{
            templateUrl : 'html/home.html'
        })
        
    <#list classes as class>
        .when('/${class.name?uncap_first}',{
            templateUrl : 'html/${class.name}.html'
        })
        
    </#list>
      
}]);