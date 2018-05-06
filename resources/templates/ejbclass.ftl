package com.ftn.mbrs.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
${class.visibility} class ${class.name} implements Serializable {  

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	
<#list properties as property>
	<#if !property.next>
	<#if property.nullable == false>
	@Column(nullable = false)
	<#elseif property.zoom>
	@ManyToOne(fetch = FetchType.EAGER)
	<#else>
	@Column
	</#if>
	<#if property.upper == 1>   
    ${property.visibility} ${property.type} ${property.name};
    
    <#elseif property.upper == -1 > 
    ${property.visibility} Set<${property.type}> ${property.name} = new HashSet<${property.type}>();
    
    <#else>   
    	<#list 1..property.upper as i>
    ${property.visibility} ${property.type} ${property.name}${i};
    
		</#list>  
    </#if>     
    </#if>
</#list>

	public ${class.name}() {}
	
	public ${class.name}(<#list properties as property><#if !property.next>${property.type} ${property.name}<#if property_has_next><#if !properties[property_index + 1].next>, </#if></#if></#if></#list>){
		<#list properties as property>
		<#if !property.next>
		this.${property.name} = ${property.name};
		</#if>
		</#list>
	}

<#list properties as property>
	<#if !property.next>
	<#if property.upper == 1 >   
      public ${property.type} get${property.name?cap_first}(){
           return ${property.name};
      }
      
      public void set${property.name?cap_first}(${property.type} ${property.name}){
           this.${property.name} = ${property.name};
      }
      
    <#elseif property.upper == -1 >
      public Set<${property.type}> get${property.name?cap_first}(){
           return ${property.name};
      }
      
      public void set${property.name?cap_first}( Set<${property.type}> ${property.name}){
           this.${property.name} = ${property.name};
      }
      
    <#else>   
    	<#list 1..property.upper as i>
      public ${property.type} get${property.name?cap_first}${i}(){
           return ${property.name}${i};
      }
      
      public void set${property.name?cap_first}${i}(${property.type} ${property.name}${i}){
           this.${property.name}${i} = ${property.name}${i};
      }
            
		</#list>  
    </#if>     
    </#if>
</#list>

}
