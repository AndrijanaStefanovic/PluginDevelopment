//Generisano na osnovu sablona: jsservice.ftl
//Element modela : ${class.name}
angular.module('${appName?uncap_first}App.${class.name}Service', [])
	.factory('${class.name}Service', function($http) {
		var factory = {};
		
		factory.findAll = function() {
			return $http.get('/${appName?uncap_first}/${class.name?uncap_first}');
		}
		
		factory.create${class.name} = function(${class.name?uncap_first} <#list class.zoomProperties as zoomProperty>, ${zoomProperty.name}Id</#list>) {
			return $http.post('/${appName?uncap_first}/${class.name?uncap_first}'<#list class.zoomProperties as zoomProperty>+'/'+${zoomProperty.name}Id</#list>, ${class.name?uncap_first});
		}

		factory.delete${class.name} = function(id) {
			return $http.delete('/${appName?uncap_first}/${class.name?uncap_first}/'+id);
		}
		
		factory.update${class.name} = function(${class.name?uncap_first}) {
			return $http.put('/${appName?uncap_first}/${class.name?uncap_first}', ${class.name?uncap_first});
		}
		
		return factory;
	});