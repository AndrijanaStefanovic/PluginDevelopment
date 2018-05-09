package com.ftn.mbrs.service;

import java.util.List;

import com.ftn.mbrs.model.${class.name};

${class.visibility} interface ${class.name}Service {

	public ${class.name} save(${class.name} ${class.name?uncap_first}<#list properties as property><#if property.zoom>, Long ${property.name}Id</#if></#list>);
	
	public ${class.name} update(${class.name} ${class.name?uncap_first});

	public void delete(Long id);
	
	public ${class.name} findOne(Long id);
	
	public List<${class.name}> findAll();
}
