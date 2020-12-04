# Como instalar o Python Pip no Ubuntu 20.04

[Pip](https://linuxize.com/post/how-to-install-pip-on-ubuntu-20.04/) é uma ferramenta para instalar pacotes Python.

```
sudo apt -y update
sudo apt -y install python3-pip
```
# Instalando o pika

[Pika](https://pypi.org/project/pika/) é uma implementação Python puro do protocolo AMQP 0-9-1, incluindo extensões RabbitMQ.

[Como instalar aqui](https://pika.readthedocs.io/en/stable/).

Python 2.7 e 3.4+ são suportados.
Como os threads não são apropriados para todas as situações, não são necessários threads. Pika core também toma cuidado para não proibi-los. O mesmo vale para greenlets, callbacks, continuações e geradores. No entanto, uma instância dos adaptadores de conexão integrados do Pika não é segura para thread.
As pessoas podem estar usando sockets diretos, select () simples e antigo , ou qualquer uma das várias maneiras de obter eventos de rede de e para um aplicativo Python. O Pika tenta se manter compatível com tudo isso e tornar a adaptação a um novo ambiente o mais simples possível.

```
pip3 install pika
```


# Executando os exemplos

Recever as mensagens.

```
python3 1_receiver.py
```

Enviar as mensagens.

```
python3 1_send.py
```

### ack (acknowledgment)

Ver [confirmação de mensagem](https://www.rabbitmq.com/tutorials/tutorial-two-python.html#Message%20acknowledgment).

Recever as mensagens com 

```
python3 2_receiver.py
```

Send: Usar o arquivo `1_send.py`

### fanout

Ver [exchanges - fanout](https://www.rabbitmq.com/tutorials/tutorial-three-python.html);

Recebe as mensagem de um exchanges chamado `log`.
```
python3 3_receiver.py
```

Enviar as mensagens para o exchanges chamado `log`.

```
python3 3_send.py
```

### Direct exchange

Ver [Direct exchange](https://www.rabbitmq.com/tutorials/tutorial-four-python.html).

Recebe as mensagem de um exchanges chamado `direct_logs`. O default são INFO e WARNING.
```
python3 4_receiver.py <TIPO>
```

Enviar as mensagens para o exchanges chamado `direct_logs`.

```
python3 4_send.py
```

### Topic exchange

Ver [Topic exchange](https://www.rabbitmq.com/tutorials/tutorial-five-python.html).

No recebimento, definir o TOPIC. No caso o send enviará <componente.severidade>, exemplo: `A.error`. Se colocar como parâmetro `A.*`, receberá tudo de A. Se colocar `B.error`, receberá apenas mensagens B.error.

```
python3 5_receiver.py A.*
```

Enviar as mensagens.

```
python3 5_send.py
```

### Remote Procedure Call ou RPC

A mensagem é enviada e retorna a origem após a função ser executada.

```
python3 6_receiver.py
```

Enviar as mensagens.

```
python3 6_send.py
```