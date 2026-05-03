package dev.rafaeldiasgarcia.mastersys.repository;

import dev.rafaeldiasgarcia.mastersys.domain.Modalidade;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ModalidadeRepository extends JpaRepository<Modalidade, Long> {
}
