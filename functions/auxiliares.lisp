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

(defun mes-em-horas (mes)
    "Considerando mes igual a 30 dias."
    (dia-em-horas (* mes 30))
)

(defun ano-em-horas (ano)
    "Considerando ano igual a 12 meses."
    (mes-em-horas (* ano 12))
)

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

(defun texto-data (ano mes dia hora)
    (format nil "~d/~d/~d, ~dh" dia mes ano hora)
)

(defun mostra-um-evento (&optional &key nome inicio fim)
    (format t "**~%")
    (format t "Evento: ~s~%" nome)
    (format t "Início: ~s~%" (apply #'texto-data (car (cdr inicio))))
    (format t "Fim:    ~s~%" (apply #'texto-data (car (cdr fim))))
    (format t "**~%")
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

(defun substitui-nil (valor substituto)
    (if (null valor)
        substituto
        valor
    )
)

(defun envolve-evento (ano mes dia hora ev)
    (let (
            (comeco            (apply #'data-em-horas-inicio ev)) 
            (final             (apply #'data-em-horas-fim ev)) 
            (instante-comeco   (data-em-horas ano (substitui-nil mes 12) (substitui-nil dia 30) (substitui-nil hora 23))) 
            (instante-fim      (data-em-horas ano (substitui-nil mes  1) (substitui-nil dia   1) (substitui-nil hora  0))) 
        )
        (and (>= instante-comeco comeco) (<= instante-fim final))
    )
)

(defun contem-evento (ano mes dia)
    (loop for ev in *eventos* do
        (when (envolve-evento ano mes dia nil ev)
            (return-from contem-evento T)
        )
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

(defun filtra-meses (mes-inicial mes-final)
    (if (null mes-final)
        (if (null mes-inicial)      ;; final é nulo
            (return-from filtra-meses (loop for i from 1 to 12 collect i))     ;; final e inicial são nulos
            (return-from filtra-meses (loop for i from (nome-mes-para-numero mes-inicial) to 12 collect i))        ;; inicial não é nulo
        )
        (if (null mes-inicial)      ;; final não é nulo
            (return-from filtra-meses (loop for i from 1 to (nome-mes-para-numero mes-final) collect i))       ;; final não nulos e inicial nulo
            (return-from filtra-meses (loop for i from (nome-mes-para-numero mes-inicial) to (nome-mes-para-numero mes-final) collect i))      ;; final e inicial são nulos
        )
    )
)

(defun parseia-meses (mes-inicial mes-final mes-especifico)
    (if (null mes-especifico)
        (return-from parseia-meses          (filtra-meses mes-inicial mes-final))
        (return-from parseia-meses          (list (nome-mes-para-numero mes-especifico)))
    )
)

(defun clear ()
    (screen:clear-window (screen:make-window))
)