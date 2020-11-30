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

1. Execute o arquivo `create-haproxy-rabbitmq-cluster.sh` para criar a imagem do proxy;
2. Execute o arquivo `start.sh` para "subir" os nodes;
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
- `storage-remove.sh`: Remove a pasta storage.

<!-- ROADMAP -->

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
