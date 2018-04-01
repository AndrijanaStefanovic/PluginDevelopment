angular.module('mbrsApp.${class.name}Controller',[])
    .controller('${class.name}Controller', function ($scope, ${class.name}Service <#list zoomProperties as zoomProperty>, ${zoomProperty.name?cap_first}Service </#list>) {
    
    	$scope.${class.name?uncap_first}List = [];
    <#list zoomProperties as zoomProperty>
    	$scope.${zoomProperty.name}List = [];	
    </#list>
    	$scope.sortType     = '${properties[0].name}';
    	$scope.sortReverse  = false;  
    	
    	${class.name}Service.findAll()
    		.then(function successCallback(response) {
    			$scope.${class.name?uncap_first}List = response.data;
    		}, function errorCallback(response){
    			toastr.error("Greska");
    		})

	<#list zoomProperties as zoomProperty>
		${zoomProperty.name?cap_first}Service.findAll()
    		.then(function successCallback(response) {
    			$scope.${zoomProperty.name}List = response.data;
    		}, function errorCallback(response){
    			toastr.error("Greska");
    		})
	</#list>

    	$scope.openCreateModal = function() {
    		$scope.${class.name?uncap_first} = {};
    	<#list zoomProperties as zoomProperty>
    		$scope.${class.name?uncap_first}.${zoomProperty.name} = {}
    	</#list>
    		$('#create${class.name}Modal').modal('toggle');
    	}
    		
    	$scope.create${class.name} = function() {
    		${class.name}Service.create${class.name}($scope.${class.name?uncap_first} <#list zoomProperties as zoomProperty>, $scope.${class.name?uncap_first}.${zoomProperty.name}.id </#list>)
    			.then(function successCallback(response) {
    				$scope.${class.name?uncap_first}List.push(response.data);
    				 $('#create${class.name}Modal').modal('toggle');
    			})
    	}

    	$scope.delete${class.name} = function(${class.name?uncap_first}) {
    		${class.name}Service.delete${class.name}(${class.name?uncap_first}.id)
    			.then(function successCallback(response) {
    				var index = $scope.${class.name?uncap_first}List.indexOf(${class.name?uncap_first});
    				$scope.${class.name?uncap_first}List.splice(index, 1); 
    		})
    	}
    	
    	$scope.openUpdateModal = function(${class.name?uncap_first}) {
    	<#list zoomProperties as zoomProperty>
    		document.getElementById("updateSelect${zoomProperty.name?capitalize}").value = ${class.name?uncap_first}.${zoomProperty.name}.id;
		</#list>
    		$scope.${class.name?uncap_first} = angular.copy(${class.name?uncap_first});
    		$('#update${class.name}Modal').modal('toggle');
    	}
    	
    	$scope.update${class.name} = function() {
    	<#list zoomProperties as zoomProperty>
    		$scope.${class.name?uncap_first}.${zoomProperty.name}.id = document.getElementById("updateSelect${zoomProperty.name?capitalize}").value;
    	</#list>
    		${class.name}Service.update${class.name}($scope.${class.name?uncap_first})
    			.then(function successCallback(response) {
    				$('#update${class.name}Modal').modal('toggle');
    				${class.name}Service.findAll()
    					.then(function successCallback(response) {
    						$scope.${class.name?uncap_first}List = response.data;
    					}, function errorCallback(response){
    						toastr.error("Greska");
    				})
    		})
    	}
    	
    });