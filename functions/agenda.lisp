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
            (format t "Mês ~a (~d)~%" (nome-mes m) m)

            ;; TODO: validar se data tem evento
            (loop for d in (filtra dia 30) do
                (if (contem-evento ano m d)
                    (format t " *~d*" d)
                    (format t " ~d" d)
                )
            )
            (terpri) ;;(print("\n"))
        )
    )
)