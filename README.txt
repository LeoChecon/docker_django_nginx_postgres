< PT-BR >
Essa amostra tem os seguintes objetivos:

-> Reduzir o tempo necessário para produzir e entregar um aplicativo baseado em django, servido com gunicorn (webserver), nginx (reverse proxy) e postgres (database);
-> Dockerizar os serviços da aplicação, facilitando o deploy da mesma em um ambiente de produção;

Requisitos:
...Django:
  -> Alterar o mínimo as configurações, fazendo apenas os ajustes necessários para ver a aplicação rodando e se conectando com o banco de dados;
...Docker:
  -> 3 containers distintos, um para cada serviço essencial: django, webserver, database
  -> Funcionar tanto com docker compose quanto com docker swarm (stacks)
  
  
< English > 
This sample has the following objectives:

-> Reduce the time needed to produce and deliver a django-based application, served with gunicorn (webserver), nginx (reverse proxy) and postgres (database);
-> Dockerize the application services, facilitating its deployment in a production environment;

Requirements:
...Django:
   -> Change the settings as little as possible, making only the necessary adjustments to see the application running and connecting to the database;
...Docker:
   -> 3 distinct containers, one for each essential service: django, webserver, database
   -> Work with both docker compose and docker swarm (stacks)
