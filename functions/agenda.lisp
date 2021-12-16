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

(defun calendario (&optional &key ano mes-inicial mes-final mes-especifico dia)
    (if (null ano)
        (format t "Erro: Ano necessário!~%")

        (let
            (
                (meses      (parseia-meses mes-inicial mes-final mes-especifico)) 
            )
        
            (loop for m in meses do
                (terpri)
                (format t "~d - \"~a\"~%" m (nome-mes m))

                (loop for d in (filtra dia 30) do
                    (if (contem-evento ano m d)
                        (format t "*~d* " d)
                        (format t   "~d " d)
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
)

(defun calendario-eventos (&optional &key ano)
    (if (null ano)
        (format t "Erro: Ano necessário!~%")

        (loop for m from 1 to 12 do
            (if (contem-evento ano m nil)
                (progn
                    (terpri)
                    (format t "~d - \"~a\"" m (nome-mes m))
                    (terpri)
                    (loop for d from 1 to 30 do
                        (if (contem-evento ano m d)
                            (format t "*~d* " d)
                        )
                    )
                    (terpri)
                )
            )
        )
    )
)