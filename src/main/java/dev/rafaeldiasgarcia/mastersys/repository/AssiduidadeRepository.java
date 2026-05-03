package dev.rafaeldiasgarcia.mastersys.repository;

import dev.rafaeldiasgarcia.mastersys.domain.Assiduidade;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AssiduidadeRepository extends JpaRepository<Assiduidade, Long> {
}
