<div ng-controller='${class.name}Controller'>
<h1>${class.name}</h1>

<table class="table table-hover">
	<thead>
		<tr>
			<#list properties as property>
				<#if property.uiProperty>
				<td><a data-ng-click="sortType = '${property.name}'">${property.label}<span
					data-ng-show="sortType == '${property.name}'" class="fa fa-caret-down"></span>
				</a></td>
				</#if>
			</#list>
		</tr>
	</thead>

	<tbody>

		<tr data-ng-repeat="x in ${class.name}List | orderBy:sortType:sortReverse">
			<#list properties as property>
				<#if property.uiProperty>
					<td>{{x.${property.name}}}</td>
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
				<#list properties as property>
					<#if property.uiProperty>
						<#if property.componentKind == "textField">
							<input type="text" placeholder="${property.label}" data-ng-model="${class.name?lower_case}.${property.name}"><br>
						</#if>	
					</#if>
					<#if property.zoom>
						<select name="select${property.name?capitalize}" id="select${property.name?capitalize}" ng-model="${class.name?lower_case}.${property.name}.id">
							<option ng-repeat="x in ${property.name}List" value="{{x.id}}">
								{{x.id}}
							</option>
						</select>
					</#if>
				</#list>
				<br>
			</div>
			<div class="modal-footer">
				<button data-ng-click="create${class.name}()" class="btn btn-primary">U redu</button>
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
				<#list properties as property>
					<#if property.uiProperty>
						<#if property.componentKind == "textField">
							<input type="text" placeholder="${property.label}" data-ng-model="${class.name?lower_case}.${property.name}"><br>
						</#if>	
					</#if>
				</#list>
				<br>
			</div>
			<div class="modal-footer">
				<button data-ng-click="update${class.name}()" class="btn btn-primary">U redu</button>
				<input type="button" class="btn btn-primary" value="Otkaži" data-dismiss="modal">
			</div>
		</div>
	</div>
</div>
</div>