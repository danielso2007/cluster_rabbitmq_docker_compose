![GitHub package version](https://img.shields.io/github/package-json/v/danielso2007/cluster_rabbitmq_docker_compose.svg)
[![GitHub pull requests](https://img.shields.io/github/issues-pr-raw/danielso2007/cluster_rabbitmq_docker_compose.svg)](https://github.com/danielso2007/cluster_rabbitmq_docker_compose/pulls)
[![GitHub issues](https://img.shields.io/github/issues/danielso2007/cluster_rabbitmq_docker_compose.svg)](https://github.com/danielso2007/cluster_rabbitmq_docker_compose/issues?q=is%3Aopen+is%3Aissue)
![GitHub last commit](https://img.shields.io/github/last-commit/danielso2007/cluster_rabbitmq_docker_compose.svg)
[![GitHub issue/pull request author](https://img.shields.io/github/issues/detail/u/danielso2007/cluster_rabbitmq_docker_compose/1.svg)](https://github.com/danielso2007/cluster_rabbitmq_docker_compose/pulls)
![GitHub contributors](https://img.shields.io/github/contributors/danielso2007/cluster_rabbitmq_docker_compose.svg)
![GitHub top language](https://img.shields.io/github/languages/top/danielso2007/cluster_rabbitmq_docker_compose.svg)
[![GitHub](https://img.shields.io/github/license/danielso2007/cluster_rabbitmq_docker_compose.svg)](https://github.com/danielso2007/cluster_rabbitmq_docker_compose)
[![GitHub All Releases](https://img.shields.io/github/downloads/danielso2007/cluster_rabbitmq_docker_compose/total.svg)](https://github.com/danielso2007/cluster_rabbitmq_docker_compose/archive/master.zip)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/danielso2007/cluster_rabbitmq_docker_compose">
    <img src="images/rabbitmq-logo.png" alt="Logo">
  </a>

  <h3 align="center">Cluster RabbitMQ com Docker Compose</h3>

  <p align="center">
    Exemplo de clusterização do RabbitMQ com docker e proxy reverso
  </p>
</p>

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a>
     <ul>
        <li><a href="#other-commands">Other Commands</a></li>
      </ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#introdução">Introdução</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## About The Project

Criação de cluster com [RabbitMQ](https://www.rabbitmq.com/trademark-guidelines.html) e com [haproxy](http://www.haproxy.org/) load balance.

### Built With

- [Docker](https://www.docker.com/)
- [Docker-compose](https://docs.docker.com/compose/)
- [RabbitMQ](https://www.rabbitmq.com/trademark-guidelines.html)
- [haproxy](http://www.haproxy.org/)

<!-- GETTING STARTED -->

## Getting Started

É necessário instalar o docker e o docker-compose apenas.

### Prerequisites

É importante qe você tenha acesso a **sudo** de usa máquina.

### Installation

Apenas baixe os arquivos desse repositório.

<!-- USAGE EXAMPLES -->

## Usage

1. Execute o arquivo `create-haproxy-rabbitmq-cluster.sh` para criar a imagem do proxy (execute apenas uma vez);
2. Execute o arquivo `create.sh` para criar e "subir" os nodes;
   2.1. Neste momento serão criados variáveis de ambiente para a configuração dos clusters;
   2.2. É iniciado os dockers em background `docker-compose up -d`;
   2.3. Depois para cada node, é configurado o node principal.
3. Para acessar o RabbitMQ principal, utilize a url [http://localhost:15671/#/](http://localhost:15671/#/);
   3.1. Utilize o login: **quest** e senha **quest**;
4. Neste momento o load balance também será iniciado;
   4.1. Acesse pelo endereço [http://localhost:1936/](http://localhost:1936/);
   4.2. Utilize o login: **haproxy** e senha **haproxy**;

### Other Commands

- `start.sh`: Inicia os containers.
- `stop.sh`: Para dos containers.
- `exec-it-01.sh`: Acessa o container node-1.
- `exec-it-02.sh`: Acessa o container node-2.
- `logs.sh`: Exibe os logs dos containers.
- `remove.sh`: Para os containers e os remove.
- `remove_volumes.sh`: Para os containers, os remove e apaga todos os volumes.
- `storage-remove.sh`: Remove a pasta storage;
- `add-user.sh [username] [vhost]`: Adiciona novo usuário no RabbitMQ;
- `delete-user.sh [username]`: Remove um usuário no node RabbitMQ.

## Projeto de teste

Há um projeto de teste em nodejs na pasta [exemplo_nodejs](exemplo_nodejs/README.md).

## Roadmap

Consulte os [open issues](https://github.com/danielso2007/cluster_rabbitmq_docker_compose/issues) para obter uma lista de recursos propostos (e problemas conhecidos).

<!-- CONTRIBUTING -->

## Contributing

As contribuições são o que torna a comunidade de código aberto um lugar incrível para aprender, inspirar e criar. Quaisquer contribuições que você fizer são **muito apreciadas**.

1. Faça um fork do projeto
2. Crie seu Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Faça commit de suas alterações (`git commit -m 'Add some AmazingFeature'`)
4. Envie para o Branch (`git push origin feature/AmazingFeature`)
5. Abra uma solicitação pull

<!-- LICENSE -->

## License

Distribuído sob a licença Apache License 2.0. Veja `LICENSE` para mais informações.

# Introdução

RabbitMQ é um agente de mensagens: aceita e encaminha mensagens. Você pode pensar nisso como uma agência de correio: quando você coloca a correspondência que deseja postar em uma caixa de correio, pode ter certeza de que o Sr. ou Sra. Carteiro entregará a correspondência ao destinatário. Nesta analogia, RabbitMQ é uma caixa postal, uma agência dos correios e um carteiro.

A principal diferença entre o RabbitMQ e os correios é que ele não lida com papel, ao invés disso, ele aceita, armazena e encaminha blobs binários de dados - mensagens.

O RabbitMQ e as mensagens em geral usam alguns jargões.

- **Producer** significa nada mais do que enviar. Um programa que envia mensagens é um **producer**:

<img src="images/producer.webp" alt="producer">

- Uma **queue** é o nome de uma caixa de correio que vive dentro do RabbitMQ. Embora as mensagens fluam pelo RabbitMQ e seus aplicativos, elas só podem ser armazenadas em uma fila . Uma queue é limitada apenas pelos limites de memória e disco do host, é essencialmente um grande buffer de mensagem. Muitos produtores podem enviar mensagens que vão para uma fila e muitos consumidores podem tentar receber dados de uma fila . É assim que representamos uma **queue**:

<img src="images/queue.webp" alt="producer">

- **Consuming** tem um significado semelhante a receber. Um **consumer** é um programa que geralmente espera receber mensagens:

<img src="images/consumer.webp" alt="producer">

Observe que o produtor, o consumidor e o corretor não precisam residir no mesmo host; na verdade, na maioria dos aplicativos, não. Um aplicativo pode ser produtor e consumidor também.

