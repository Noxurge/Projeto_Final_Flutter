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
import com.devti.aula.model.Cliente;
import com.devti.aula.services.ClienteService;

@RestController
@RequestMapping("/cliente")
public class ClienteResource {

	@Autowired
	ClienteService service;
	
	@GetMapping
	public List<Cliente> listarTodos() {
		return service.listarTodos();
	}
	
	@DeleteMapping("/{id}")
	public void excluir(@PathVariable ("id") int id) {
		service.excluir(id);
	}
	
	@PutMapping
	public Cliente alterar(@RequestBody Cliente c) {
		return service.alterar(c);
	}
	
	@PostMapping
	public Cliente inserirCliente(@RequestBody Cliente c) {
		System.out.println("teste");
		return service.incluir(c);
	}
	
	@GetMapping("/{cidade}")
	public List<Cliente> buscarPorNome(@PathVariable("cidade") String c){
		return service.buscarPorCidade(c);
	}
}
