#!/usr/bin/env python
import pika
import time

def callback(ch, method, properties, body):
	print(" [x] Received %r" % body)
	time.sleep(0.6)
	print(" [x] Done")
	ch.basic_ack(delivery_tag = method.delivery_tag)
	
credentials = pika.PlainCredentials('quest', 'quest')
parameters = pika.ConnectionParameters('localhost', 5672, '/', credentials)

connection = pika.BlockingConnection(parameters)
channel = connection.channel()

channel.queue_declare(queue='python_hello')

channel.basic_consume(queue='python_hello', auto_ack=False, on_message_callback=callback)
					  
print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming()
