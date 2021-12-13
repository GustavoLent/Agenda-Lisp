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
