package com.ftn.mbrs.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ftn.mbrs.model.Kartica;
import com.ftn.mbrs.model.Vozilo;
import com.ftn.mbrs.repository.KarticaRepository;
import com.ftn.mbrs.repository.VoziloRepository;
import com.ftn.mbrs.service.KarticaService;

@Service
${class.visibility} class ${class.name}ServiceImpl implements ${class.name}Service{

	@Autowired
	private ${class.name}Repository karticaRepository;
	
	//
	@Autowired
	private VoziloRepository voziloRepository;
	
	//
	@Override
	public ${class.name} save(${class.name} kartica) {
		return karticaRepository.save(kartica);
	}

	//
	@Override
	public ${class.name} update(${class.name} kartica) {
		Kartica temp = karticaRepository.getOne(kartica.getId());
		temp.setImeVlasnika(kartica.getImeVlasnika());
		temp.setPrezimeVlasnika(kartica.getPrezimeVlasnika());
		temp.setKredit(kartica.getKredit());
		temp.setDate(kartica.getDate());
		return karticaRepository.save(temp);
	}

	//
	@Override
	public void delete(Long id) {
		Kartica kartica = karticaRepository.getOne(id);
		List<Vozilo> vozila = voziloRepository.findByKartica(kartica);
		for (Vozilo vozilo : vozila) {
			voziloRepository.delete(vozilo);
		}
		karticaRepository.deleteById(id);
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
