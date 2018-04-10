angular.module('${appName?uncap_first}App.controllers',[
	<#list classes as class>
	'${appName?uncap_first}App.${class.name}Controller',
	</#list>
]);