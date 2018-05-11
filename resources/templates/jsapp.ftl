//${currentDate}
//Generisano na osnovu sablona: jsapp.ftl

var app = angular.module('${appName?uncap_first}App', [
	'${appName?uncap_first}App.controllers',
    '${appName?uncap_first}App.services',
    '${appName?uncap_first}App.routes',
    '${appName?uncap_first}App.directives'
]);