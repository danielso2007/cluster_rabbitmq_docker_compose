#!/usr/bin/env python
# -*- coding: utf-8 -*-
import pika

def callback(ch, method, properties, body):
	print(" [x] Received %r" % body)


# Set the connection parameters to connect to rabbit-server1 on port 5672
# on the / virtual host using the username "guest" and password "guest"
credentials = pika.PlainCredentials('quest', 'quest')
parameters = pika.ConnectionParameters('localhost', 5672, '/', credentials)

connection = pika.BlockingConnection(parameters)
channel = connection.channel()

channel.queue_declare(queue='python_hello')

channel.basic_consume(queue='python_hello', auto_ack=True, on_message_callback=callback)
					  
print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
