# Agenda Lisp #

> Projeto desenvolvido para a disciplina **Linguagens de Programação Não Convencionais**, ministrada pelo [Professor Dr. Thiago Gottardi](https://bv.fapesp.br/pt/pesquisador/104729/thiago-gottardi/), durante o sexto semestre da graduação em [Bacharelado em Ciências da Computação na Unesp de Rio Claro](https://igce.rc.unesp.br/#!/departamentos/demac/pagina-do-curso-de-bcc/home/).


## Para iniciar o projeto, faça: ##
* Inicialize o contâiner Docker com:
```docker
    docker run -d -t --name clisp Cl foundation/clisp
```

* Copie os arquivos com as funções para o contâiner:
```bash
    docker cp .\functions\agenda.lisp clisp:/home/agenda.lisp
    docker cp .\functions\eventos.lisp clisp:/home/eventos.lisp
    docker cp .\functions\auxiliares.lisp clisp:/home/auxiliares.lisp
```

* Acesse o contâiner "clisp" e chame o REPL clisp:
```bash
    docker exec -it clisp bash
    cd home
    clisp
```

* No interpretador CLISP, importe o arquivo agenda.lisp:
``` lisp
    (load "agenda.lisp")
```

* Execute as funções da agenda,
``` lisp
    (calendario :ano 2021)
    (calendario-eventos :ano 2021)
    (mostra-eventos :ano 2021)
```

* Exemplo da função calendário:
``` lisp
    (calendario :ano 2021)
        ;; Irá retornar todos os meses e dias daquele ano

    (calendario :ano 2021 :mes-especifico 7)
        ;; Irá retornar os dias para o mês específico

    (calendario :ano 2021 :mes-inicial 7)
        ;; Irá retornar os dias para os meses 7 a 12 (inclusivo)

    (calendario :ano 2021 :mes-final 9)
        ;; Irá retornar os dias para os meses 1 a 9 (inclusivo)

    (calendario :ano 2021 :mes-inicial 7 :mes-final 9)
        ;; Irá retornar os dias para os meses 7 a 9 (inclusivo)

    (calendario :ano 2021 :mes-inicial 7 :mes-final 9 :mes-especifico 3)
        ;; Irá retornar os dias para o mês específico, somente
```
