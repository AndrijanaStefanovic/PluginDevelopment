//${currentDate}
//Generisano na osnovu sablona: jscontrollers.ftl

angular.module('${appName?uncap_first}App.controllers',[
	<#list classes as class>
	'${appName?uncap_first}App.${class.name}Controller',
	</#list>
	'${appName?uncap_first}App.ButtonController'
]);