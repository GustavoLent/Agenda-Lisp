# Agenda Lisp #

> Projeto desenvolvido para a disciplina **Linguagens de Programação Não Convencionais**, ministrada pelo [Professor Dr. Thiago Gottardi](https://bv.fapesp.br/pt/pesquisador/104729/thiago-gottardi/), durante o sexto semestre da graduação em [Bacharelado em Ciências da Computação na Unesp de Rio Claro](https://igce.rc.unesp.br/#!/departamentos/demac/pagina-do-curso-de-bcc/home/).

## Para rodar o projeto, faça: ##
* Abra o interpretador CLISP e importe os dois arquivos com:
``` lisp
    (load "eventos.lisp")
    (load "agenda.lisp")
```
* As duas funções principais são "agenda" e "mostra-eventos",
``` lisp
    (calendario :ano 2021)
    (mostra-eventos :ano 2021)
```
