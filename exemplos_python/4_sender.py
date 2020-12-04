#!/usr/bin/env python
import random
import pika
import time
import threading
interval = 0.4


def sendFunction():
    credentials = pika.PlainCredentials('quest', 'quest')
    parameters = pika.ConnectionParameters('localhost', 5672, '/', credentials)
    connection = pika.BlockingConnection(parameters)
    channel = connection.channel()

    channel.exchange_declare(exchange='direct_logs', exchange_type='direct')
    channel = connection.channel()

    severities = ["info", "error", "warning", "error", "info"]

    msg = "Id= %s" % random.randrange(111111, 999999)
    severity = severities[random.randrange(0, 4)]
    channel.basic_publish(exchange='direct_logs', routing_key=severity, body=msg)
    print(" [x] Sent %r:%r" % (severity, msg))

    connection.close()


def startTimer():
    threading.Timer(interval, startTimer).start()
    sendFunction()


print(' [*] Waiting for messages. To exit press CTRL+C')
startTimer()
