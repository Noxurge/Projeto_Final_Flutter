package com.devti.aula.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devti.aula.model.Cidade;
import com.devti.aula.repository.CidadeRepository;

@Service
public class CidadeService {

	@Autowired
	CidadeRepository rep;
	
	public List<Cidade> buscarPorUf(String uf) {
		return rep.findByUf(uf);
	}
	
	public Optional<Cidade> buscarPorId(Integer id) {
		return rep.findById(id);
	}
	
	public void excluir(Integer id) {
		Cidade cidadeExcluir = rep.findById(id).get();
		if (cidadeExcluir != null) {
			rep.delete(cidadeExcluir);
		}
	}
	
	public Cidade incluir(Cidade c) {
		return rep.save(c);
	}
	
	public List<Cidade> listarTodas(){
		return rep.findAll();
	}
	
	public Cidade alterar(Cidade c) {
		return rep.save(c);
	}
	
}
