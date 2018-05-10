package com.ftn.mbrs.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ftn.mbrs.model.${class.name};
<#list properties as property>
	<#if property.zoom>
import com.ftn.mbrs.model.${property.name?cap_first};
	</#if>
</#list>

${class.visibility} interface ${class.name}Repository extends JpaRepository<${class.name}, Long> {

<#list properties as property>
	<#if property.zoom>
	public List<${class.name}> findBy${property.name?cap_first}(${property.name?cap_first} ${property.name?uncap_first});
	</#if>
</#list>

}