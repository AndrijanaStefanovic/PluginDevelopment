package com.ftn.mbrs.controller;

import java.util.List;

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
	
	@RequestMapping(method = RequestMethod.POST)
	public ResponseEntity<${class.name}> save(@Valid @RequestBody ${class.name} ${class.name?uncap_first}) {
		${class.name} saved${class.name} = ${class.name?uncap_first}Service.save(${class.name?uncap_first});
		return new ResponseEntity<${class.name}>(saved${class.name}, HttpStatus.CREATED);
	}
	
	@RequestMapping(method = RequestMethod.PUT)
	public ResponseEntity<${class.name}> update(@Valid @RequestBody ${class.name} ${class.name?uncap_first}) {
		${class.name} updated${class.name} = ${class.name?uncap_first}Service.update(${class.name?uncap_first});
		return new ResponseEntity<${class.name}>(updated${class.name}, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public ResponseEntity<Long> delete(@PathVariable Long id) {
		${class.name?uncap_first}Service.delete(id);
		return new ResponseEntity<Long>(id, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<${class.name}> findOne(@PathVariable Long id) {
		${class.name} ${class.name?uncap_first} = ${class.name?uncap_first}Service.findOne(id);
		return new ResponseEntity<${class.name}>(${class.name?uncap_first}, HttpStatus.OK);
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public ResponseEntity<List<${class.name}>> findAll() {
		List<${class.name}> ${class.name?uncap_first}s = ${class.name?uncap_first}Service.findAll();
		return new ResponseEntity<List<${class.name}>>(${class.name?uncap_first}s, HttpStatus.OK);
	}
}