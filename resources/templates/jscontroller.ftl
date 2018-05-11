//${currentDate}
//Generisano na osnovu sablona: jscontroller.ftl
//Element modela: <#list importedPackages as package>${package}::</#list>${class.name}

angular.module('${appName?uncap_first}App.${class.name}Controller',[])
    .controller('${class.name}Controller', function ($scope, ${class.name}Service <#list zoomProperties as zoomProperty>, ${zoomProperty.name?cap_first}Service </#list>) {
    
    	$scope.${class.name?uncap_first}List = [];
    <#list zoomProperties as zoomProperty>
    	$scope.${zoomProperty.name}List = [];	
    </#list>
    	$scope.sortType     = '${properties[0].name}';
    	$scope.sortReverse  = false;  
    <#if class.zoomProperties?size != 0>
    	$scope.searchKeyword = "";
    </#if>
    
    <#list properties as property>
    	<#if property.componentKind == "dateChooser">
    	$scope.initDateTimePicker${property.name?cap_first} = function() {
			$('#dateTime${property.name?cap_first}').datetimepicker({
				format: 'DD-MM-YYYY HH:mm'
			});
			$('#updateDateTime${property.name?cap_first}').datetimepicker({
				format: 'DD-MM-YYYY HH:mm'
			});
		}
		
		</#if>
    </#list>
    	${class.name}Service.findAll()
    		.then(function successCallback(response) {
    			$scope.${class.name?uncap_first}List = response.data;
    		}, function errorCallback(response){
    			toastr.error("Doslo je do greske.");
    		})

	<#list zoomProperties as zoomProperty>
		${zoomProperty.name?cap_first}Service.findAll()
    		.then(function successCallback(response) {
    			$scope.${zoomProperty.name}List = response.data;
    		}, function errorCallback(response){
    			toastr.error("Doslo je do greske.");
    		})
    		
	</#list>

    	$scope.openCreateModal = function() {
    		$scope.${class.name?uncap_first} = {};
    	<#list zoomProperties as zoomProperty>
    		$scope.${class.name?uncap_first}.${zoomProperty.name} = {};
    	</#list>
    		$('#create${class.name}Modal').modal('toggle');
    	}
    		
    	$scope.create${class.name} = function() {
    <#list properties as property>	
    	<#if property.componentKind == "dateChooser">
    		var ${property.name} = $('#dateTextField${property.name?cap_first}').val();
    		$scope.${class.name?uncap_first}.${property.name} = moment(${property.name}, 'DD-MM-YYYY HH:mm');
    	</#if>
    </#list>	

    	${class.name}Service.create${class.name}($scope.${class.name?uncap_first} <#list zoomProperties as zoomProperty>, $scope.${class.name?uncap_first}.${zoomProperty.name}.id </#list>)
    			.then(function successCallback(response) {
    				$scope.${class.name?uncap_first}List.push(response.data);
    				 $('#create${class.name}Modal').modal('toggle');
    			}, function errorCallback(response){
    				toastr.error("Doslo je do greske.");
    			})
    	}

    	$scope.delete${class.name} = function(${class.name?uncap_first}) {
    		${class.name}Service.delete${class.name}(${class.name?uncap_first}.id)
    			.then(function successCallback(response) {
    				if(response.data != "OK") {
    					toastr.error("Nije moguce brisanje.");
    				} else {
    					var index = $scope.${class.name?uncap_first}List.indexOf(${class.name?uncap_first});
    					$scope.${class.name?uncap_first}List.splice(index, 1); 
    				}
    			}, function errorCallback(response){
    				toastr.error("Doslo je do greske.");
    			})
    	}
    	
    	$scope.openUpdateModal = function(${class.name?uncap_first}) {
    	<#list zoomProperties as zoomProperty>
    		document.getElementById("updateSelect${zoomProperty.name?cap_first}").value = ${class.name?uncap_first}.${zoomProperty.name}.id;
		</#list>
		<#list properties as property>
			<#if property.componentKind == "dateChooser">
			$("#updateDateTextField${property.name?cap_first}").val(moment(${class.name?uncap_first}.${property.name}).format('DD-MM-YYYY HH:mm'));
			</#if>
		</#list>
    		$scope.${class.name?uncap_first} = angular.copy(${class.name?uncap_first});
    		$('#update${class.name}Modal').modal('toggle');
    	}
    	
    	$scope.update${class.name} = function() {
    	<#list zoomProperties as zoomProperty>
    		$scope.${class.name?uncap_first}.${zoomProperty.name}.id = document.getElementById("updateSelect${zoomProperty.name?cap_first}").value;
    	</#list>
    	<#list properties as property>
    		<#if property.componentKind == "dateChooser">
    		var ${property.name} = $('#updateDateTextField${property.name?cap_first}').val();
    		$scope.${class.name?uncap_first}.${property.name} = moment(${property.name}, 'DD-MM-YYYY HH:mm');
    		</#if>
    	</#list>
    		${class.name}Service.update${class.name}($scope.${class.name?uncap_first})
    			.then(function successCallback(response) {
    				$('#update${class.name}Modal').modal('toggle');
    				${class.name}Service.findAll()
    					.then(function successCallback(response) {
    						$scope.${class.name?uncap_first}List = response.data;
    					}, function errorCallback(response){
    						toastr.error("Doslo je do greske.");
    				})
    			}, function errorCallback(response){
    				toastr.error("Doslo je do greske.");
    			})
    	}
    	
    	<#if class.zoomProperties?size != 0>
    	$scope.filterFunction = function(${class.name?uncap_first}) {
    		if($scope.searchKeyword == "")
    			return true;
    		var check = <#list class.zoomProperties as zoomProperty><#list zoomProperty.showProperties as show>${class.name?uncap_first}.${zoomProperty.name}.${show}+" "+</#list></#list>" ";
    		if(check.includes($scope.searchKeyword))
    	    {
    	       	return true; 
    	    }
    		return false;
    	};
	   </#if>
    	
    });