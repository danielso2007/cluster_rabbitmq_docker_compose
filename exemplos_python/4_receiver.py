#!/usr/bin/env python
import pika
import sys


def callback(ch, method, properties, body):
    print(" [x] %r:%r" % (method.routing_key, body))

credentials = pika.PlainCredentials('quest', 'quest')
parameters = pika.ConnectionParameters('localhost', 5672, '/', credentials)
connection = pika.BlockingConnection(parameters)
channel = connection.channel()

channel.exchange_declare(exchange='direct_logs', exchange_type='direct')

result = channel.queue_declare('', exclusive=True)
queue_name = result.method.queue

severities = sys.argv[1:]
if not severities:
    severities = ['info', 'warning']
    sys.stderr.write("Usage: %s\n" % severities)
# sys.stderr.write("Usage: %s [info] [warning] [error]\n" % sys.argv[0])
# sys.exit(1)

for severity in severities:
    channel.queue_bind(exchange='direct_logs', queue=queue_name, routing_key=severity)

print(' [*] Waiting for logs. To exit press CTRL+C')

channel.basic_consume(queue=queue_name, on_message_callback=callback, auto_ack=True)

channel.start_consuming()
