#!/usr/bin/env node

var amqp = require('amqplib/callback_api');

amqp.connect('amqp://quest:quest@localhost:5672', function(error0, connection) {
    if (error0) {
        throw error0;
    }
    connection.createChannel(function(error1, channel) {
        if (error1) {
            throw error1;
        }

        var queue = 'Queue-hello';

        channel.assertQueue(queue, {
            durable: false
        });

        console.log(" [*] Waiting for messages in %s. To exit press CTRL+C", queue);

        channel.consume(queue, function(msg) {
            console.log(" [x] Received %s - Msg: %s", msg.fields.routingKey, msg.content.toString());
        }, {
            noAck: true
        });
    });
});