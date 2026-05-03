package dev.rafaeldiasgarcia.mastersys.repository;

import dev.rafaeldiasgarcia.mastersys.domain.Aluno;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AlunoRepository extends JpaRepository<Aluno, Long> {
    boolean existsByEmail(String email);
}
