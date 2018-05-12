<!-- Generisano na osnovu sablona home.ftl -->
<#list classes as class>
<a href="#/${class.name?uncap_first}"><#list class.name?split("(?=[A-Z])", "r") as token>${token} </#list></a> </br>
</#list>
