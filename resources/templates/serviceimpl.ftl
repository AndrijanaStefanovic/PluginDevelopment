package com.ftn.mbrs.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

<#list properties as property><#if property.zoom>
import com.ftn.mbrs.model.${property.name?cap_first};
import com.ftn.mbrs.repository.${property.name?cap_first}Repository;
</#if></#list>

<#list nextProperties as property>
import com.ftn.mbrs.model.${property.name?cap_first};
import com.ftn.mbrs.repository.${property.name?cap_first}Repository;
</#list>

import com.ftn.mbrs.service.${class.name}Service;
import com.ftn.mbrs.model.${class.name};
import com.ftn.mbrs.repository.${class.name}Repository;

@Service
${class.visibility} class ${class.name}ServiceImpl implements ${class.name}Service{

	@Autowired
	private ${class.name}Repository ${class.name?uncap_first}Repository;

	<#list nextProperties as property>
	@Autowired
	private ${property.name?cap_first}Repository ${property.name}Repository;
	
	</#list>
			
	<#list properties as property><#if property.zoom>
	@Autowired
	private ${property.name?cap_first}Repository ${property.name}Repository;
	
	</#if></#list>
	
	@Override
	public ${class.name} save(${class.name} ${class.name?uncap_first}<#list properties as property><#if property.zoom>, Long ${property.name}Id</#if></#list>) {
		<#list properties as property><#if property.zoom>
		${property.name?cap_first} ${property.name} =  ${property.name}Repository.getOne(${property.name}Id);
		${class.name?uncap_first}.set${property.name?cap_first}(${property.name});
	
		</#if></#list>	
		return ${class.name?uncap_first}Repository.save(${class.name?uncap_first});
	}

	//
	@Override
	public ${class.name} update(${class.name} ${class.name?uncap_first}) {		
		${class.name} temp${class.name} = ${class.name?uncap_first}Repository.getOne(${class.name?uncap_first}.getId());
		
		<#list properties as property>
		<#if !property.next && !property.zoom>   
		temp${class.name}.set${property.name?cap_first}(${class.name?uncap_first}.get${property.name?cap_first}());    	
    	</#if>
    	</#list>
    	 	
    	<#list properties as property><#if property.zoom>
		${property.name?cap_first} temp${property.name?cap_first} = ${property.name}Repository.getOne(${class.name?uncap_first}.get${property.name?cap_first}().getId());
		temp${class.name}.set${property.name?cap_first}(temp${property.name?cap_first});
		</#if></#list>	
		
		return ${class.name?uncap_first}Repository.save(temp${class.name});
	}

	//
	@Override
	public String delete(Long id) {
		${class.name} ${class.name?uncap_first} = ${class.name?uncap_first}Repository.getOne(id);
		
		<#list nextProperties as property>   
		List<${property.name?cap_first}> ${property.name}s = ${property.name?uncap_first}Repository.findBy${class.name}(${class.name?uncap_first});
		if(!${property.name}s.isEmpty()) {
			return "ERROR";
		}    	
		</#list>
		
		${class.name?uncap_first}Repository.deleteById(id);
		return "OK";
	}

	@Override
	public ${class.name} findOne(Long id) {
		return ${class.name?uncap_first}Repository.getOne(id);
	}

	@Override
	public List<${class.name}> findAll() {
		return ${class.name?uncap_first}Repository.findAll();
	}

}
