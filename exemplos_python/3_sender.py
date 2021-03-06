#!/usr/bin/env python
# -*- coding: utf-8 -*-
import pika
import time
import threading
import random
interval = 0.3


def sendFunction():
# Set the connection parameters to connect to rabbit-server1 on port 5672
# on the / virtual host using the username "guest" and password "guest"
    credentials = pika.PlainCredentials('quest', 'quest')
    parameters = pika.ConnectionParameters('localhost', 5672, '/', credentials)
    connection = pika.BlockingConnection(parameters)

    channel = connection.channel()
    channel.exchange_declare(exchange='logs', exchange_type='fanout')

    message = "Id= %s" % random.randrange(111111, 999999)

    channel.basic_publish(exchange='logs', routing_key='', body=message)
    print(" [x] Enviada '" + message + "'")

    connection.close()


def startTimer():
    threading.Timer(interval, startTimer).start()
    sendFunction()


print(' [*] Waiting for messages. To exit press CTRL+C')
startTimer()
