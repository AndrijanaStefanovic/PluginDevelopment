package ${class.typePackage};

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
${class.visibility} class ${class.name} implements Serializable {  

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	
<#list properties as property>
	<#if property.nullable == false>
	@Column(nullable = false)
	<#else>
	@Column
	</#if>
	<#if property.upper == 1 >   
    ${property.visibility} ${property.type} ${property.name};
    
    <#elseif property.upper == -1 > 
    ${property.visibility} Set<${property.type}> ${property.name} = new HashSet<${property.type}>();
    
    <#else>   
    	<#list 1..property.upper as i>
    ${property.visibility} ${property.type} ${property.name}${i};
    
		</#list>  
    </#if>     
</#list>

	public ${class.name}() {}
	
	public ${class.name}(<#list properties as property>${property.type} ${property.name}<#if property_has_next>, </#if></#list>){
		<#list properties as property>
		this.${property.name} = ${property.name};
		</#list>
	}

<#list properties as property>
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
</#list>

}
