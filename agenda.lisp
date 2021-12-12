;; Altere para retornar T somente se "a" igual a "b"
;; por exemplo, compare todos os nomes e datas do evento.
;; Aviso: a ou b são listas ou números.
;; Pode ser necessário testar se algum é nil.
;; Se algum for nil, apenas retorne T se ambos forem nil; senão, compare cada elemento.
;; Dica: (null a) testa se a é nil.

(defun compara-igual (a b)
    "Compara se a é igual a b."
    (eql a b )
)
;; altere para retornar T somente se "a" maior que "b"
;; por exemplo, compare as datas de início do evento.
;; É mais fácil converter as datas em horas antes de comparar.
;; A e B são números ou listas não vazias.
(defun compara-maior (a b)
"Compara se a é maior que b."
(> a b )
)
(defun maior-recursivo (x o-maior)
 "Retorna o maior elemento da lista x."
 (if (endp x)
       o-maior
(if (compara-maior (car x) o-maior)
   (maior-recursivo (cdr x) (car x))
   (maior-recursivo (cdr x) o-maior)
)
 )
)
(defun maior (x)
"Retorna o maior elemento da lista x."
(maior-recursivo x (car x))
)
(defun exceto (retira lista)
 "Retorna a lista 'lista' sem elemento 'retira'."
 (loop for i in lista when (not (compara-igual retira i) ) collect i)
 )
(defun ordena-recursivo (entrada saida)
 "Retira elementos de 'entrada' e move para lista 'saida' de forma ordenada. Algoritmo selection sort, seleciona maior e move para o final. Exclui elementos duplicados."
 (if (endp entrada)
     saida
     (concatenate 'list (ordena (exceto (maior entrada) entrada)) (list (maior entrada)) )
 )
)
(defun ordena (entrada)
"Retorna lista 'entrada' como ordenada e sem elementos duplicados."
(ordena-recursivo entrada '())
)
;; exemplo de uso: (ordena '(1 2 4 5 6 4 3 6 5)) retorna (1 2 3 4 5 6)

(defun compara-igual (a b)
"Compara se a é igual a b (apenas para listas)."
(if (eql a b)
  T
         (if (eql (length a) (length b))
	(if (eql (car a) (car b))
		(compara-igual (cdr a) (cdr b))
		nil ;; cabeça diferente
	)
	nil ;; tamanho diferente
  )
)
)

(defun dia-em-horas (dia)
    "Considerando um dia igual a 24 horas."
    (* dia 24)
)

;; observação: pode ser necessário mudar número de dias.
(defun mes-em-horas (mes)
    "Considerando mes igual a 30 dias."
    (dia-em-horas (* mes 30))
)

;; observação: pode ser necessário mudar número de meses.
(defun ano-em-horas (ano)
    "Considerando ano igual a 12 meses."
    (mes-em-horas (* ano 12))
)

;; observação: pode ser melhor alterar ordem dos parâmetros.
(defun data-em-horas (ano mes dia hora)
  "Retorna data em horas de acordo com as funções anteriores"
 (if (>= ano 0)
   (+ (ano-em-horas ano) (mes-em-horas mes) (dia-em-horas dia) hora)
   (- (ano-em-horas ano) (mes-em-horas mes) (dia-em-horas dia) hora)
 )
)

(defun nome-mes (mes)
    (let ((nomes #(nil "Janeiro" "Fevereiro" "Março" "Abril" "Maio" "Junho" "Julho" "Agosto" "Setembro" "Outubro" "Novembro" "Dezembro")))
        (aref nomes mes)
    )
)

(defun filtra (parametro elementos)
    (if (null parametro)
        (loop for i from 1 to elementos collect i)
        (list parametro)
    )
)

(defun calendario (&optional &key ano mes dia hora)
    (if (null ano)
        (format t "Erro: Ano necessário!~%")

        (loop for m in (filtra (nome-mes-para-numero mes) 12) do
            (format t "Mês ~a (~d)~%" (nome-mes m) m)

            ;; TODO: validar se data tem evento
            (loop for d in (filtra dia 30) do
                (format t " ~d" d)
            )
            (terpri) ;;(print("\n"))
        )
    )
)

(defun texto-data (ano mes dia hora)
    (format nil "~d-~d-~d, ~dh" ano mes dia hora)
)

(defun mostra-um-evento (&optional &key nome inicio fim)
    (format t "Evento: ~s~%" nome)
    (format t "Início: ~s~%" (apply #'texto-data (car (cdr inicio))))
    (format t "Fim: ~s~%" (apply #'texto-data (car (cdr fim))))
    (terpri)
)

(defun data-em-horas-inicio (&optional &key nome inicio fim)
    (apply #'data-em-horas (car (cdr inicio)))
)

(defun data-em-horas-fim (&optional &key nome inicio fim)
    (apply #'data-em-horas (car (cdr fim)))
)

(defun compara-maior (a b)
    (> (apply #'data-em-horas-inicio a) (apply #'data-em-horas-inicio b))
)

(defun envolve-evento (ano mes dia hora ev)
    (defun substitui-nil (valor substituto)
        (if (null valor)
            substituto
            valor
        )
    )
    (let (
            (comeco            (apply #'data-em-horas-inicio ev)) 
            (final             (apply #'data-em-horas-fim ev)) 
            (instante-comeco   (data-em-horas ano (substitui-nil mes 12) (substitui-nil dia 30) (substitui-nil hora 23))) 
            (instante-fim      (data-em-horas ano (substitui-nil mes  1) (substitui-nil dia   1) (substitui-nil hora  0))) 
        )
        (and (>= instante-comeco comeco) (<= instante-fim final))
    )
)

(defun nome-mes-para-numero (mes)
    (if (or (null mes) (integerp mes))
        mes
        (loop for i from 1 to 12 do
            (when (string= (nome-mes i) mes)
                (return-from nome-mes-para-numero i)
            )
        )
    )
)

(defun mostra-eventos (&optional &key ano mes dia hora)
    (loop for ev in (ordena *eventos*) do
        ; (apply (function mostra-um-evento) ev)
        (when (envolve-evento ano (nome-mes-para-numero mes) dia hora ev)
            (apply (function mostra-um-evento) ev)
        )
    )
)
