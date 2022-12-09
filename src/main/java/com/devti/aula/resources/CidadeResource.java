package com.devti.aula.resources;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.devti.aula.model.Cidade;
import com.devti.aula.services.CidadeService;

@RestController
@RequestMapping("/cidade")
public class CidadeResource {

	@Autowired
	CidadeService service;
	
	@DeleteMapping("/{id}")
	public void excluir(@PathVariable ("id") int id) {
		service.excluir(id);
	}
	
	@PutMapping
	public Cidade alterar(@RequestBody Cidade c) {
		return service.alterar(c);
	}
	
	@PostMapping
	public Cidade inserirCidade(@RequestBody Cidade c) {
		return service.incluir(c);
	}
	
	@GetMapping
	public List<Cidade> listarTodas(){
		return service.listarTodas();
	}
	
	@GetMapping("/{uf}")
	public List<Cidade> buscarPorUf(@PathVariable("uf") String uf){
		return service.buscarPorUf(uf);
	}
	
}
