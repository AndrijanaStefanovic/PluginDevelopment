angular.module('${appName?uncap_first}App.services',[
	<#list classes as class>
	'${appName?uncap_first}App.${class.name}Service',
	</#list>
]);