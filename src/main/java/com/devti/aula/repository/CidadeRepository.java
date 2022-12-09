package com.devti.aula.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.devti.aula.model.Cidade;

@Repository
public interface CidadeRepository extends JpaRepository<Cidade, Integer>{

	public List<Cidade> findByUf(String uf);
	
}
