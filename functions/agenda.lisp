(load "eventos.lisp")
(load "auxiliares.lisp")

(defun mostra-eventos (&optional &key ano mes dia hora)
    (loop for ev in (ordena *eventos*) do
        ; (apply (function mostra-um-evento) ev)
        (when (envolve-evento ano (nome-mes-para-numero mes) dia hora ev)
            (apply (function mostra-um-evento) ev)
        )
    )
)

(defun calendario (&optional &key ano mes dia hora)
    (if (null ano)
        (format t "Erro: Ano necessário!~%")

        (loop for m in (filtra (nome-mes-para-numero mes) 12) do
            (if (contem-evento ano m nil)
                (format t "~c[94m~d-\"~a\" ~c[0m~%" #\ESC m (nome-mes m) #\ESC)
                (format t "~d-\"~a\"~%" m (nome-mes m))
            )

            (loop for d in (filtra dia 30) do
                (if (contem-evento ano m d)
                    (format t "~c[94m*~d*~c[0m " #\ESC d #\ESC)
                    (format t "~d " d)
                )
            )
            ; (when (contem-evento ano m nil)
            ;     (format t "~%~c[94m* Eventos do mês ~s: ~c~%[0m" #\ESC (nome-mes m) #\ESC)
            ;     (mostra-eventos :ano ano :mes m)
            ; )
            (terpri)
        )
    )
)

(defun calendario-eventos (&optional &key ano)
    (if (null ano)
        (format t "Erro: Ano necessário!~%")

        (loop for m from 1 to 12 do
            (if (contem-evento ano m nil)
                (progn
                    (format t "~c[94m~d-\"~a\" ~c[0m~%" #\ESC m (nome-mes m) #\ESC)
                    (loop for d from 1 to 30 do
                        (if (contem-evento ano m d)
                            (format t "~c[94m*~d*~c[0m " #\ESC d #\ESC)
                            (format t "~d " d)
                        )
                    )
                    (terpri)
                )
            )
        )
    )
)