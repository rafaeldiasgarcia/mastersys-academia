package dev.rafaeldiasgarcia.mastersys.exception;

import java.time.LocalDateTime;
import java.util.List;

public record ErroResponse(

        LocalDateTime timestamp,
        Integer status,
        String error,
        List<String> messages
) {
}
