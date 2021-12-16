# Agenda Lisp #

> Projeto desenvolvido para a disciplina **Linguagens de Programação Não Convencionais**, ministrada pelo [Professor Dr. Thiago Gottardi](https://bv.fapesp.br/pt/pesquisador/104729/thiago-gottardi/), durante o sexto semestre da graduação em [Bacharelado em Ciências da Computação na Unesp de Rio Claro](https://igce.rc.unesp.br/#!/departamentos/demac/pagina-do-curso-de-bcc/home/).

## Alunos ##
------------
* [Bruna Félix](https://github.com/BrunaFelix)
* [Gustavo Lima Lent](https://github.com/GustavoLent)
* [Guilherme Henrique Jardim](https://github.com/ghjardim)
* [José Fernandes Russino](https://www.linkedin.com/in/zefernandes0/)

## Inicialização do projeto: ##
-------------------------------
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

## Uso das funções: ##
----------------------
A agenda possui três funções principais: calendario, calendario-eventos e mostra-eventos.

### ( calendario :ano :mes-inicial :mes-final :mes-especifico :dia ) ###

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

**Considerações**
* Quando houver um evento, o dia aparecerá destacado com um asterisco **\*** ao seu redor
``` lisp
    [1]> (calendario :ano 2021 :mes-especifico 7)

    7 - "Julho"
    1 2 3 4 5 6 7 8 9 *10* 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
```
* O único parâmetro obrigatório é o **ano**, os demais são opcionais.

### ( calendario-eventos :ano ) ###

``` lisp
    ( calendario-eventos :ano 2021 )
```

**Considerações**
* Tem como objetivo listar todos os eventos de um ano especifico, exibindo somente os meses e dias.

``` lisp
    [1]>  ( calendario-eventos :ano 2021)
    
    1 - "Janeiro"
    *7* *12*
    
    2 - "Fevereiro"
    *23* *24*
    
    5 - "Maio"
    *8* *9* *10* *11* *12* *13* *14* *15* *16* *17* *18* *19* *20* *21* *22* *23* *24* *25* *26* *27* *28*
    
    7 - "Julho"
    *10*

    9 - "Setembro"
    *1* *2* *3* *4* *5* *6* *7* *8* *9* *10* *11* *12* *13* *14* *15* *16* *17* *18* *19* *20* *21* *22* *23* *24* *25* *26* *27* *28* *29* *30*

```

* O parâmetro **ano** é obrigatório.

### ( mostra-eventos :ano :mes :dia :hora ) ###
```lisp
    (mostra-eventos :ano 2021)
        ;; Irá retornar todos os eventos deste ano

    (mostra-eventos :ano 2021 :mes "Julho")
        ;; Irá retornar todos os eventos deste ano, no mês especificado

    (mostra-eventos :ano 2021 :mes "Julho" :dia 10)
        ;; Irá retornar todos os eventos deste ano, no mês e dias especificados
```

**Considerações**
* Tem como objetivo listar todos os eventos encontrados de acordo como os campos invocados na função.
```lisp
    [1]> (mostra-eventos :ano 2021 :mes "Julho" :dia 10)
    **
    Evento: "Day off"
    Início: "10/7/2021, 1h"
    Fim:    "10/7/2021, 23h"
```
* Irá retornar NIL caso não encontre nenhum evento.
* O parâmetro **ano** é obrigatório.

## Inclusão de novas informações: ##
------------------------------------
Para adicionar eventos na agenda acesse o arquivo ["eventos.lisp"](../agenda-lisp/functions/eventos.lisp) e adicione o seguinte exemplo na linha `";; adição de novos eventos"`:

``` lisp
    (:inicio '(2022 3  13 16) :fim '(2022 3  13 22) :nome "Recepção Bixos")
```

Com isso, o arquivo deve estar de acordo com o seguinte:

``` lisp
    (defvar *eventos*
        '(
            (:inicio '(2021 1  7 19) :fim '(2021 1  7 22) :nome "Jantar Empresa")
            (:inicio '(2021 1 12 11) :fim '(2021 1 12 13) :nome "Prova Autoescola")
            (:inicio '(2021 2 23  8) :fim '(2021 2 24  8) :nome "Deploy Projeto")
            (:inicio '(2021 5  8 14) :fim '(2021 5 28 14) :nome "Curso TS")
            (:inicio '(2021 7 10  1) :fim '(2021 7 10 23) :nome "Day off")
            (:inicio '(2021 9  1  9) :fim '(2021 9 30  9) :nome "Estudar Clojure")
            (:inicio '(2022 3  13 16) :fim '(2022 3  13 22) :nome "Recepção Bixos")
            ;; adição de novos eventos
        )
    )
```

Note que as informações sobre o inicio e fim do evento seguem o padrão **ano mês dia hora**, e o nome do evento deve estar entre aspas.

**Depois de adicionado o novo evento, envie o arquivo novamente para o contâiner (caso não tenha realizado a alteração dentro dele), reinicialize o REPL de clisp e reimporte as funções com `(load "agenda.lisp")`.**