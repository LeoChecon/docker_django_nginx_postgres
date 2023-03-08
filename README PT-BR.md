# Apresentação

## Por que criei esse repositório?

Digamos que você esteja iniciando no mundo da programação e começou a aprender a utilizar o `django` para criar páginas web. Tudo vai as mil maravilhas, até você descobrir que seu amado `python manage.py runserver` não poderá te acompanhar quando o jogo começar a valer de verdade.

Você faz uma pesquisa e rapidamente descobre que a coisa é um pouco mais complicada do que você imaginou, e logo começam a surgir palavras como `servidor web`, `proxy reverso`, `portas 80 e 443`, `variáveis de ambiente`, `Virtual Machines`, etc...

![til](examples/monty-python-gif01.gif)

"Caramba, eu mal sei usar o `django` direito e já tenho que aprender esse sem-fim de tecnologias correlatas para fazer um mero "Hello World!" em um ambiente de produção!"* 😭

## Se você está se sentindo assim, você veio ao lugar certo!

Criar uma aplicação em `django` e utiliza-la em um ambiente de produção pode ser **exaustivo e frustante** quando estamos começando a aprender a programar. Na verdade, diversas tecnologias são necessárias para fazer o deploy de uma aplicação desse tipo, das quais podemos citar minimamente as seguintes:

* `Nginx`
* `Gunicorn`
* Um banco de dados relacional, como `Postgres` ou `Mysql`

Obviamente, cada uma dessas tecnologias é um mundo a parte e possui suas minúcias, que exigem do programador **dedicação e tempo** de estudo para que sejam configuradas de forma ótima dentro do contexto de sua aplicação.

Não pretendo com esse **modelo** resolver todos os seus problemas de deploy, mas pelo menos te dar um norte de como iniciar um projeto e reduzir suas idas e vindas ao `Stackoverflow` para criar uma configuração básica e funcional para ambiente de produção.

![til](examples/monty-python-gif02.gif)

## Como utilizar esse modelo?

### Eu preciso saber `Docker` para testar esse modelo?

NÃO! Apenas instale os seguintes **requisitos** e siga as orientações abaixo.

**Requisitos:**

* Python 3 (https://realpython.com/installing-python/)
* Docker (https://docs.docker.com/engine/install/)

**Orientações:**

Existem três opções distintas e independentes de utilização desse modelo, são elas: **modo desenvolvimento**, **modo produção com docker compose**, **modo produção com docker swarm**.

Após clonar o repositório para a pasta desejada do seu computador abra um prompt de comando ou terminal na raiz do repositório e siga as seguintes instruções...

### Modo desenvolvimento

1. Instale a biblioteca `pipenv` do python (https://pipenv.pypa.io/en/latest/index.html)
2. Inicie um ambiente virtual: `pipenv shell`
3. Instale as dependências do projeto: `pipenv install`;
4. Mude de diretório para a pastas docker_django e inicie o servidor de desenvolvimento do `django`: `python manage.py runserver --insecure`

*No modo de desenvolvimento optamos por utilizar como banco de dados o Sqlite3 a fim de não exigir que você tenha que baixar uma versão do Postgres na sua máquina.*

*A flag `--insecure` é exigida para permitir que o servidor web do django exiba as `static files` quando no arquivo `settings.py` o valor de `DEBUG` está settado como `False`*

### Modo produção com docker compose

Para iniciar a aplicação faça o seguinte:  

1. Verifique se as linhas 94 e 96 do arquivo `docker-compose.yml` estão comentadas. Se não, **COMENTE-AS**. Para isso, digite um # no início da linha e salve o arquivo;
2. Inicie o serviço do `Docker`
3. Execute o comando `docker compose up`
4. Aguarde até que todos os três serviços sejam iniciados corretamente e estejam com o status

> Você pode confirmar que os serviços foram iniciados corretamente e estão rodando no `dashboard` do docker...![til](examples/docker%20compose%20dashboard%20-%20containers.png)
>... ou utilizando o comando `docker compose ps` em um outro terminal![til](examples/docker%20compose%20ps.png)

Para encerrar a aplicação faça o seguinte:  

1. No terminal ou prompt de comando digite `Ctrl+C`
2. (opcional) Digite o comando `docker compose down -v --rmi local` para apagar completamente os arquivos gerados pelo modo compose, incluindo o banco de dados e os containers criados;

### Modo produção com docker swarm mode

Para iniciar a aplicação faça o seguinte:  

1. Verifique se as linhas 94 e 96 do arquivo `docker-compose.yml` estão comentadas. Se sim, **DESCOMENTE-AS**. Para isso, apague o # no início da linha e salve o arquivo;
2. Inicie o serviço do `Docker`
3. Inicie o `swarm mode` digitando o comando `docker swarm init`
4. Construa as imagens dos containers: `docker compose build`
5. Execute a aplicação: `docker stack deploy -c docker-compose.yml my_stack_name`
6. Aguarde até que todos os **três serviços** sejam iniciados corretamente e estejam com o status igual a `running`

> Você pode confirmar que os serviços foram iniciados corretamente e estão rodando no `dashboard` do docker...![til](examples/docker%20dashboard%20-%20containers.png)
>... ou utilizando o comando `docker stack ps my_stack_name`![til](examples/docker%20stack%20ps%20command%20output.png)

7. Abra no seu navegador a página `localhost:8080`

Para encerrar a aplicação faça o seguinte:

1. Execute o comando `docker stack rm my_stack_name`
2. (opcional) Saia do modo swarm: `docker swarm leave --force`

## Entendendo o código

### Hierarquia de arquivos e pastas

* **Pasta docker_django**:
  * Arquivos da aplicação django (`docker_django`);
  * Pasta do dummy-app `new_app`;
  * Pasta gerada automaticamente pelo comando `python manage.py collectstatic`;
  * Arquivo do banco de dados sqlite, utilizado para testes no modo de desenvolvimento (`db.sqlite3`);
  * Arquivo de configuração para inicialização do serviço `django` do Docker (`django_entrypoint.sh`);
  * Arquivo de configuração do Gunicorn (`gunicorn.conf.py`);
* **Pasta nginx config**:
  * arquivos de configuração do `nginx`, utilizados pelo `Docker` para criar o respectivo container;
* **Pasta secret_files**: contém os arquivos utilizados pelo `docker secrets` para montar os containers. São eles: 
  * database_name: nome do banco de dados;
  * database_password: senha do banco de dados;
  * database_user: usuário do banco de dados;
  * django_key: valor do secret_key presente no `settings.py` do `django`;
* **Arquivos .Dockerfile**: utilizados para construir os containers localmente;
* **Arquivo docker-compose.yml**: utilizado para construir os containers e rodar do `Docker`;
* **Arquivos Pipfile e Pipfile.lock:** utilizados para construir um `virtualenv` para testes locais usando a biblioteca `pipenv` (https://pipenv.pypa.io/en/latest/index.html);
* **Arquivo requirements.txt**:  utilizados para construir um `virtualenv` para testes locais usando `pip` (https://packaging.python.org/en/latest/guides/installing-using-pip-and-virtual-environments/);
  * Atenção: o `Docker` utiliza esse arquivo para baixar e instalar as dependências do projeto no respectivo container;

### Configurações do Docker

Foram criados três serviços distintos utilizando o `Docker`, são eles:

| Serviço | Dockerfile |
| --- | --- |
| database | _postgres.Dockerfile |
| webserver | _nginx.Dockerfile |
| django | _django.Dockerfile |

Caso queira fazer uso de `variáveis de ambiente` adicionais, recomenda-se adiciona-las diretamente no arquivo `docker-compose.yml`

### Configurações do `django`

A aplicação `django` está dentro da pasta **docker_django**: sem novidades, configure como preferir. Caso queira alterar o `STATIC_ROOT` e o `STATIC_URL` talvez seja necessário fazer ajustes nos arquivos de configuração do `nginx` - do contrário, tudo já está configurado e funcional.

### Configurações do `nginx`

*Em construção...*

## Por que usar o Docker?

> O `Docker` elimina tarefas de configuração repetitivas e mundanas e é usado em todo o ciclo de vida do desenvolvimento para desenvolvimento de aplicativos rápido, fácil e portátil – desktop e nuvem. A plataforma abrangente de ponta a ponta do Docker inclui UIs, CLIs, APIs e segurança que são projetados para trabalhar juntos em todo o ciclo de vida de entrega do aplicativo. [ *traduzido de* https://www.docker.com/ ]

O `Docker` é uma ferramenta que permite montar as partes de sua aplicação em serviços independentes e isolados, auxiliando no deploy da aplicação. Com ele fica muito mais fácil rodar o app em ambientes distintos, desde que esse ambiente seja capaz de rodar o Docker. Isso reduz - e muito! - o tempo necessário para configurar `Virtual Machines`, por exemplo.

