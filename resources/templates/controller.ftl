//${currentDate}
//Generisano na osnovu sablona: controller.ftl
//Element modela: <#list importedPackages as package>${package}::</#list>${class.name}

package com.ftn.mbrs.controller;

import java.util.List;
import java.util.ArrayList;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ftn.mbrs.model.${class.name};
import com.ftn.mbrs.service.${class.name}Service;

@RestController
@RequestMapping("${class.name?uncap_first}")
${class.visibility} class ${class.name}Controller {

	@Autowired
	private ${class.name}Service ${class.name?uncap_first}Service;
	
	@RequestMapping(<#list properties as property><#if property.zoom>value = "/<#break></#if></#list><#list properties as property><#if property.zoom>{${property.name?uncap_first}Id}<#if property_has_next><#list properties as prop><#if property_index < prop_index && prop.zoom>/<#break></#if></#list></#if><#if !property_has_next>", </#if></#if></#list>method = RequestMethod.POST)
	public ResponseEntity<${class.name}> save(@Valid @RequestBody ${class.name} ${class.name?uncap_first}<#list properties as property><#if property.zoom>, @PathVariable Long ${property.name?uncap_first}Id</#if></#list>) {
		try
		{
			${class.name} saved${class.name} = ${class.name?uncap_first}Service.save(${class.name?uncap_first}<#list properties as property><#if property.zoom>, ${property.name?uncap_first}Id</#if></#list>);
			return new ResponseEntity<${class.name}>(saved${class.name}, HttpStatus.CREATED);
		}
		catch(Exception e)
		{
			return new ResponseEntity<${class.name}>(${class.name?uncap_first}, HttpStatus.FORBIDDEN);
		}
	}
	
	@RequestMapping(method = RequestMethod.PUT)
	public ResponseEntity<${class.name}> update(@Valid @RequestBody ${class.name} ${class.name?uncap_first}) {
		try
		{
			${class.name} updated${class.name} = ${class.name?uncap_first}Service.update(${class.name?uncap_first});
			return new ResponseEntity<${class.name}>(updated${class.name}, HttpStatus.OK);
		}
		catch(Exception e)
		{
			return new ResponseEntity<${class.name}>(${class.name?uncap_first}, HttpStatus.FORBIDDEN);
		}
	}
		
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/plain")
	public ResponseEntity<String> delete(@PathVariable Long id) {
		try
		{
			String response = ${class.name?uncap_first}Service.delete(id);
			return new ResponseEntity<String>(response, HttpStatus.OK);
		}
		catch(Exception e)
		{
			return new ResponseEntity<String>(id.toString(), HttpStatus.FORBIDDEN);
		}
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<${class.name}> findOne(@PathVariable Long id) {
		try
		{
			${class.name} ${class.name?uncap_first} = ${class.name?uncap_first}Service.findOne(id);
			return new ResponseEntity<${class.name}>(${class.name?uncap_first}, HttpStatus.OK);
		}
		catch(Exception e)
		{
			return new ResponseEntity<${class.name}>(new ${class.name}(), HttpStatus.FORBIDDEN);
		}
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public ResponseEntity<List<${class.name}>> findAll() {
		try{
		List<${class.name}> ${class.name?uncap_first}s = ${class.name?uncap_first}Service.findAll();
		return new ResponseEntity<List<${class.name}>>(${class.name?uncap_first}s, HttpStatus.OK);
		}
		catch(Exception e)
		{		
		return new ResponseEntity<List<${class.name}>>(new ArrayList<${class.name}>(), HttpStatus.FORBIDDEN);
		}
		
	}
}