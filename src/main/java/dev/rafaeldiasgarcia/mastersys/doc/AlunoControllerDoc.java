package dev.rafaeldiasgarcia.mastersys.doc;

import dev.rafaeldiasgarcia.mastersys.dto.AlunoRequest;
import dev.rafaeldiasgarcia.mastersys.dto.AlunoResponse;
import dev.rafaeldiasgarcia.mastersys.exception.ErroResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.RequestBody;

@Tag(
        name = "Alunos",
        description = "Operações para cadastro, consulta, atualização, exclusão e filtragem de alunos"
)
public interface AlunoControllerDoc {

    @Operation(
            summary = "Cadastrar aluno",
            description = "Cria um novo aluno no sistema de academia",
            responses = {
                    @ApiResponse(
                            responseCode = "201",
                            description = "Aluno cadastrado com sucesso"
                    ),
                    @ApiResponse(
                            responseCode = "400",
                            description = "Erro de validação ou regra de negócio",
                            content = @Content(schema = @Schema(implementation = ErroResponse.class))
                    )
            }
    )
    AlunoResponse cadastrar(
            @Valid
            @RequestBody
            @io.swagger.v3.oas.annotations.parameters.RequestBody(
                    description = "Dados para cadastro de um novo aluno",
                    required = true,
                    content = @Content(
                            schema = @Schema(implementation = AlunoRequest.class),
                            examples = @ExampleObject(
                                    name = "Aluno valido",
                                    value = """
                                            {
                                                "nome": "João da Silva",
                                                  "dataNascimento": "1995-08-15",
                                                  "sexo": "M",
                                                  "telefone": "4833334444",
                                                  "celular": "4899998888",
                                                  "email": "joao@email.com",
                                                  "obsevacao": "Aluno iniciante",
                                                  "endereco": "Rua das Flores",
                                                  "numero": "123",
                                                  "complemento": "Apartamento 202",
                                                  "bairro": "Centro",
                                                  "cidade": "Criciúma",
                                                  "estado": "SC",
                                                  "cep": "88802410"
                                            }  
                                            """
                            ))
            )
            AlunoRequest alunoRequest
    );
}
