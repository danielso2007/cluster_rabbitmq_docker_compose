#!/usr/bin/env python
import pika
import time
import threading
import random
interval = 0.09

def sendFunction():
    credentials = pika.PlainCredentials('quest', 'quest')
    parameters = pika.ConnectionParameters('localhost', 5672, '/', credentials)
    connection = pika.BlockingConnection(parameters)
    channel = connection.channel()

    channel.exchange_declare(exchange='topic_logs', exchange_type='topic')

    severities = ["info", "error", "warning"]
    components = ["A", "B", "C"]

    message = '{ id: %s, documento: %s }' % (random.randrange(111111, 999999), random.randrange(100000000000, 999999999999))
    severity = severities[random.randrange(0, 3)]
    component = components[random.randrange(0, 3)]

    routing_key = component + "." + severity

    channel.basic_publish(exchange='topic_logs', routing_key=routing_key, body=message)
    
    print(" [x] Sent %r:%r" % (routing_key, message))
    
    time.sleep(1)

    connection.close()

def startTimer():
    threading.Timer(interval, startTimer).start()
    sendFunction()

print(' [*] Waiting for messages. To exit press CTRL+C')
startTimer()