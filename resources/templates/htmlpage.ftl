<!-- ${currentDate} -->
<!-- Generisano na osnovu sablona: htmlpage.ftl -->
<!-- Element modela: <#list importedPackages as package>${package}::</#list>${class.name} -->

<div ng-controller='${class.name}Controller'>
<h1><#assign count = 0><#list class.name?cap_first?split("(?=[A-Z])", "r") as token><#if count == 0>${token} <#else>${token?uncap_first} </#if><#assign count = count + 1></#list></h1>
<#if class.name == "Kartica">
<button-directive></button-directive>
</#if>
<#if class.zoomProperties?size != 0>
<input type="text" class="form-control ng-valid ng-dirty" placeholder="Pretraga" data-ng-model="searchKeyword">
</#if>

<table class="table table-hover">
	<thead>
		<tr>
			<#list properties as property>
				<#if property.uiProperty>
			<td><a data-ng-click="sortType = '${property.name}'">${property.label}<span
				data-ng-show="sortType == '${property.name}'" class="fa fa-caret-down"></span>
			</a></td>
				</#if>
				<#if property.zoom>
					<#list property.showProperties as show>
			<td><a data-ng-click="sortType = '${property.name}.${show}'"><#assign count = 0><#list show?cap_first?split("(?=[A-Z])", "r") as token><#if count == 0>${token} <#else>${token?uncap_first} </#if><#assign count = count + 1></#list><span
				data-ng-show="sortType == '${property.name}.${show}'" class="fa fa-caret-down"></span>
			</a></td>
					</#list>
				</#if>
			</#list>
		</tr>
	</thead>

	<tbody>

		<tr data-ng-repeat="x in ${class.name?uncap_first}List | orderBy:sortType:sortReverse<#if class.zoomProperties?size != 0> | filter:filterFunction </#if>">
			<#list properties as property>
				<#if property.uiProperty>
			<td>{{x.${property.name} <#if property.componentKind == "dateChooser">| date : "dd-MM-yyyy HH:mm" </#if>}}</td>
				</#if>
				<#if property.zoom>
					<#list property.showProperties as show>
			<td>{{x.${property.name}.${show}}}</td>
					</#list>
				</#if>
			</#list>
			
			<td>
				<button type="button" class="btn btn-info" data-ng-click="openUpdateModal(x)">
					<span class="glyphicon glyphicon-pencil"></span>
				</button>
				<button type="button" class="btn btn-danger" data-ng-click="delete${class.name}(x)">
					<span class="glyphicon glyphicon-remove"></span>
				</button>
			</td>
		</tr>
	</tbody>
</table>

<button type="button" class="btn btn-info" data-ng-click="openCreateModal()">Dodaj</button>

<div id="create${class.name}Modal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Dodavanje</h4>
			</div>
			<div class="modal-body">
				<form name="createForm">
				<#list properties as property>
					<#if property.zoom>
					<label for="select${property.name?cap_first}"><#assign count = 0><#list property.name?cap_first?split("(?=[A-Z])", "r") as token><#if count == 0>${token} <#else>${token?uncap_first} </#if><#assign count = count + 1></#list></label>
					<select name="select${property.name?cap_first}" id="select${property.name?cap_first}" ng-model="${class.name?uncap_first}.${property.name}.id" required>
						<option ng-repeat="x in ${property.name}List" value="{{x.id}}">
							<#list property.showProperties as show>{{x.${show}}} </#list>
						</option>
					</select>
					</#if>
					<#if property.uiProperty>
						<#if property.componentKind == "textField">
					<label>${property.label}</label>
					<input type="<#if property.type == "int" || property.type == "float">number<#else>text</#if>" data-ng-model="${class.name?uncap_first}.${property.name}" <#if property.type == "int" || property.type == "float"><#else>maxlength="${property.length}" </#if><#if !property.nullable>required </#if>><br>
						</#if>
						<#if property.componentKind == "dateChooser">
						<label for="dateTime${property.name?cap_first}"><#assign count = 0><#list property.name?cap_first?split("(?=[A-Z])", "r") as token><#if count == 0>${token} <#else>${token?uncap_first} </#if><#assign count = count + 1></#list></label>
						<div class="input-group date" id="dateTime${property.name?cap_first}" data-ng-init="initDateTimePicker${property.name?cap_first}()">
				 			<input type="text" class="form-control" id="dateTextField${property.name?cap_first}"/> 
				 			<span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span></span> 
						</div> 
						</#if>	
					</#if>
				</#list>
				<br>
				</form>
			</div>
			<div class="modal-footer">
				<button data-ng-click="create${class.name}()" class="btn btn-primary" data-ng-disabled="!createForm.$valid">U redu</button>
				<input type="button" class="btn btn-primary" value="Otkaži" data-dismiss="modal">
			</div>
		</div>
	</div>
</div>

<div id="update${class.name}Modal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Izmena</h4>
			</div>
			<div class="modal-body">
				<form name="updateForm">
				<#list properties as property>
					<#if property.zoom>
					<label for="updateSelect${property.name?cap_first}"><#assign count = 0><#list property.name?cap_first?split("(?=[A-Z])", "r") as token><#if count == 0>${token} <#else>${token?uncap_first} </#if><#assign count = count + 1></#list></label>
					<select id="updateSelect${property.name?cap_first}" required>
						<option data-ng-repeat="x in ${property.name}List" value="{{x.id}}">
								<#list property.showProperties as show>{{x.${show}}} </#list>
						</option>
					</select>
					</#if>
					<#if property.uiProperty>
						<#if property.componentKind == "textField">
						<label>${property.label}</label>
						<input type="<#if property.type == "int" || property.type == "float">number<#else>text</#if>" data-ng-model="${class.name?uncap_first}.${property.name}" <#if property.type == "int" || property.type == "float"> <#else>maxlength="${property.length}"</#if><#if property.readonly> readonly</#if> <#if !property.nullable>required</#if>><br>
						</#if>
						<#if property.componentKind == "dateChooser">
						<label for="updateDateTime${property.name?cap_first}"><#assign count = 0><#list property.name?cap_first?split("(?=[A-Z])", "r") as token><#if count == 0>${token} <#else>${token?uncap_first} </#if><#assign count = count + 1></#list></label>
						<div class="input-group date" id="updateDateTime${property.name?cap_first}" data-ng-init="initDateTimePicker${property.name?cap_first}()">
			 				<input type="text" class="form-control" id="updateDateTextField${property.name?cap_first}"/> 
			 				<span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span></span> 
						</div> 
						</#if>	
					</#if>
				</#list>
				<br>
				</form>
			</div>
			<div class="modal-footer">
				<button data-ng-click="update${class.name}()" class="btn btn-primary" data-ng-disabled="!updateForm.$valid">U redu</button>
				<input type="button" class="btn btn-primary" value="Otkaži" data-dismiss="modal">
			</div>
		</div>
	</div>
</div>
</div>

