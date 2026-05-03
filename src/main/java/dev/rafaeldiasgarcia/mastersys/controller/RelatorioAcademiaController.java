package dev.rafaeldiasgarcia.mastersys.controller;

import dev.rafaeldiasgarcia.mastersys.projection.AlunosPorCidadeProjection;
import dev.rafaeldiasgarcia.mastersys.projection.FaturamentoMensalProjection;
import dev.rafaeldiasgarcia.mastersys.projection.FaturasEmAbertoProjection;
import dev.rafaeldiasgarcia.mastersys.repository.RelatorioAcademiaRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/relatorios")
public class RelatorioAcademiaController {

    private final RelatorioAcademiaRepository relatorioAcademiaRepository;

    public RelatorioAcademiaController(RelatorioAcademiaRepository relatorioAcademiaRepository) {
        this.relatorioAcademiaRepository = relatorioAcademiaRepository;
    }

    @GetMapping("/faturamento-mensal")
    public List<FaturamentoMensalProjection> faturamentoMensal() {

        return relatorioAcademiaRepository.faturamentoMensal();
    }

    @GetMapping("/alunos-por-cidade")
    public List<AlunosPorCidadeProjection> alunosPorCidade() {

        return relatorioAcademiaRepository.alunosPorCidade();
    }

    @GetMapping("/faturas-em-aberto")
    public List<FaturasEmAbertoProjection> faturasEmAberto() {

        return relatorioAcademiaRepository.faturasEmAberto();
    }
}
