#!/usr/bin/env python
import pika

def on_request(ch, method, props, body):
    n = int(body)

    response = n*n
    print(" [.] Calculando %s * %s = %s" % (n, n, response))

    ch.basic_publish(exchange='',
                     routing_key=props.reply_to,
                     properties=pika.BasicProperties(correlation_id = \
                                                         props.correlation_id),
                     body=str(response))
    ch.basic_ack(delivery_tag=method.delivery_tag)

credentials = pika.PlainCredentials('quest', 'quest')
parameters = pika.ConnectionParameters('localhost', 5672, '/', credentials)
connection = pika.BlockingConnection(parameters)
channel = connection.channel()

channel.queue_declare(queue='rpc_queue')

channel.basic_consume(queue='rpc_queue', on_message_callback=on_request)

print(" [x] Awaiting RPC requests")
channel.start_consuming()