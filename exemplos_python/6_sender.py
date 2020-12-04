#!/usr/bin/env python
import pika
import uuid
import threading
import random
interval = 1

corr_id = ""
      
def sendFunction():
    def on_response(ch, method, props, body):
       if corr_id == props.correlation_id:
            print(" [.] Retorno %r" % body)

    credentials = pika.PlainCredentials('quest', 'quest')
    parameters = pika.ConnectionParameters('localhost', 5672, '/', credentials)
    connection = pika.BlockingConnection(parameters)
    channel = connection.channel()

    result = channel.queue_declare('', exclusive=True)
    callback_queue = result.method.queue

    channel.basic_consume(
        queue=callback_queue,
        on_message_callback=on_response,
        auto_ack=True)

    value = random.randrange(10, 100)

    print(" [x] Requesting %s * %s" % (value, value))

    corr_id = str(uuid.uuid4())
    channel.basic_publish(
        exchange='',
        routing_key='rpc_queue',
        properties=pika.BasicProperties(
            reply_to=callback_queue,
            correlation_id=corr_id,
        ),
        body=str(value))

    channel.start_consuming()

def startTimer():
    threading.Timer(interval, startTimer).start()
    sendFunction()

print(' [*] Waiting for messages. To exit press CTRL+C')
startTimer()