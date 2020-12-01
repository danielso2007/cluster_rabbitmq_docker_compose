# Rabbitmq tutorials javascript nodejs

Pequeno projeto para exemplificar o send e receive para o RabbitMQ.

## Instalação

Execute `npm i` no projeto para instalar o [amqplib](https://www.squaremobius.net/amqp.node/).

## Arquivo receive.js

Recebe as mensagem do RabbitMMQ.

`node receive.js` para executar.

Recomendado usar o comando `./logs.sh` do projeto para exibir os logs do containers.

## Arquivo send.js

Envia as mensagem.

`node send.js` para executar.

### Commandos

- `node send.js` - É enviado apenas uma mensagem;
- `node send.js 1` - É enviado apenas uma mensagem;
- `node send.js 100` - É enviado apenas cem mensagem;
- `node send.js n` - Onde **n** é a quantidade a ser enviada. O teste chegou até 210;
- `node send.js -1` - É executado um intervalo onde cada mensagem é enviada por 10 milissegundos por vez.

# amqplib
### Biblioteca e cliente AMQP 0-9-1 para Node.JS

Biblioteca e cliente AMQP 0-9-1 para Node.JS
amqplibimplementa o maquinário necessário para fazer clientes para AMQP 0-9-1 e inclui esse cliente. Por que formular dessa maneira? Como o AMQP é complicado o suficiente, existem algumas maneiras diferentes de apresentá-lo na forma de API (por exemplo, node-amqp lida com trocas e filas como objetos de primeira classe, enquanto oculta canais; rabbit.js desaprova trocas e filas em favor de roteamento padrões).

O AMQP freqüentemente parece ser projetado para confundir os desenvolvedores do cliente; não tem camadas muito limpas e há consequências em moldá-lo desta ou daquela forma em busca de uma API utilizável. Em amqplibtentei implementar apenas o maquinário necessário do AMQP, em camadas da melhor maneira que pude, sem prejuízo de qualquer API de cliente em particular.

# "Olá Mundo"

**(usando o cliente amqp.node)**
Nesta parte do tutorial, escreveremos dois pequenos programas em Javascript; um produtor que envia uma única mensagem e um consumidor que recebe mensagens e as imprime. Vamos passar por cima de alguns detalhes da API amqp.node , concentrando-nos nessa coisa muito simples apenas para começar. É um "Hello World" de mensagens.

No diagrama abaixo, "P" é nosso produtor e "C" é nosso consumidor. A caixa no meio é uma fila - um buffer de mensagem que o RabbitMQ mantém em nome do consumidor.

<img src="/images/python-one.webp">

### A biblioteca cliente amqp.node

RabbitMQ fala vários protocolos. Este tutorial usa AMQP 0-9-1, que é um protocolo aberto de uso geral para mensagens. Existem vários clientes para RabbitMQ em muitos idiomas diferentes . Usaremos o cliente amqp.node neste tutorial.

Primeiro, instale amqp.node usando npm :

```npm instalar amqplib```

Agora que temos amqp.node instalado, podemos escrever algum código.

## Enviando

<img src="/images/sending.webp">

Chamaremos nosso editor de mensagem (remetente) de `send.js` e nosso consumidor de mensagem (receptor) de `receive.js`. O editor se conectará ao RabbitMQ, enviará uma única mensagem e sairá.

Em `send.js`, precisamos exigir a biblioteca primeiro:

```
#!/usr/bin/env node

var amqp = require('amqplib/callback_api');
```

em seguida, conecte-se ao servidor RabbitMQ

```
amqp.connect('amqp://localhost', function(error0, connection) {};
```

Em seguida, criamos um canal, que é onde reside a maior parte da API para realizar as coisas:

```
amqp.connect('amqp://localhost', function(error0, connection) {
  if (error0) {
    throw error0;
  }
  connection.createChannel(function(error1, channel) {});
});
```

Para enviar, devemos declarar uma fila para enviarmos; então podemos publicar uma mensagem na fila:

```
amqp.connect('amqp://localhost', function(error0, connection) {
  if (error0) {
    throw error0;
  }
  connection.createChannel(function(error1, channel) {
    if (error1) {
      throw error1;
    }
    var queue = 'hello';
    var msg = 'Hello world';

    channel.assertQueue(queue, {
      durable: false
    });

    channel.sendToQueue(queue, Buffer.from(msg));
    console.log(" [x] Sent %s", msg);
  });
});
```

Declarar uma fila é idempotente - ela só será criada se ainda não existir. O conteúdo da mensagem é uma matriz de bytes, então você pode codificar o que quiser lá.

Por fim, fechamos a conexão e encerramos:

```
setTimeout(function() { 
  connection.close(); 
  process.exit(0) 
  }, 500);
```

[Aqui está o script send.js completo.](https://github.com/rabbitmq/rabbitmq-tutorials/blob/master/javascript-nodejs/src/send.js)

## Recebendo

É isso para o nosso editor. Nosso consumidor escuta as mensagens do RabbitMQ, então, ao contrário do editor que publica uma única mensagem, manteremos o consumidor correndo para ouvir as mensagens e imprimi-las.

<img src="/images/receiving.webp">

O código (em `receive.js`) tem o mesmo requerimento que `send`:

```
#!/usr/bin/env node

var amqp = require('amqplib/callback_api');
```

A configuração é igual à do editor; abrimos uma conexão e um canal, e declaramos a fila da qual iremos consumir. Observe que isso corresponde à fila em que `sendToQueue` publica.

```
amqp.connect('amqp://localhost', function(error0, connection) {
  if (error0) {
    throw error0;
  }
  connection.createChannel(function(error1, channel) {
    if (error1) {
      throw error1;
    }
    var queue = 'hello';

    channel.assertQueue(queue, {
      durable: false
    });
  });
});
```

Observe que declaramos a fila aqui também. Como podemos iniciar o consumidor antes do editor, queremos ter certeza de que a fila existe antes de tentarmos consumir mensagens dela.

Estamos prestes a dizer ao servidor para nos entregar as mensagens da fila. Uma vez que ele nos enviará mensagens de forma assíncrona, fornecemos um retorno de chamada que será executado quando o RabbitMQ enviar mensagens ao nosso consumidor. Isso é o que `Channel.consume` faz.

```
console.log(" [*] Waiting for messages in %s. To exit press CTRL+C", queue);
channel.consume(queue, function(msg) {
  console.log(" [x] Received %s", msg.content.toString());
}, {
    noAck: true
  });
```

[Aqui está todo o script receive.js.](https://github.com/rabbitmq/rabbitmq-tutorials/blob/master/javascript-nodejs/src/receive.js)

## Juntando tudo

Agora podemos executar os dois scripts. Em um terminal, na pasta rabbitmq-tutorials / javascript-nodejs / src /, execute o editor:

```
./send.js
```

então, execute o consumidor:

```
./receive.js
```

O consumidor imprimirá a mensagem que recebe do editor via RabbitMQ. O consumidor continuará executando, esperando por mensagens (use Ctrl-C para interrompê-lo), então tente executar o editor de outro terminal.

