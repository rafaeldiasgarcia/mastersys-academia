package dev.rafaeldiasgarcia.mastersys.repository;

import dev.rafaeldiasgarcia.mastersys.domain.Matricula;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MatriculaRepository extends JpaRepository<Matricula, Long> {
}
