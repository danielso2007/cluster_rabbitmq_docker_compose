#!/usr/bin/env node

var amqp = require("amqplib/callback_api");

function init() {
  let loop = getParameter();
  if (loop < 1) {
    let count = 0;
    setInterval(function () {
      connectAmqp(count++, false);
    }, 30);
  } else {
    for (let x = 0; x < loop; x++) {
      connectAmqp(x, true);
    }
  }
  console.log("Total enviado: %s", loop);
}

function connectAmqp(index, exit) {
  amqp.connect("amqp://quest:quest@localhost:5672", function (error0, connection) {
      if (error0) {
        throw error0;
      }
      send(connection, index + 1);
      //   console.log("Cluster name; %s",sendValue.connection.serverProperties.cluster_name);
      setTimeout(function () {
        console.log("connection.close()!");
        connection.close();
        if (exit) {process.exit(0);}
      }, 200);
    }
  );
}

function getParameter() {
  let param = 1;

  process.argv.forEach(function (val, index, array) {
    val = parseInt(val);
    if (Number.isInteger(val)) {
      param = val;
    }
  });
  console.log(`Param recebido: %s`, param);
  return param;
}

function send(connection, index) {
  return connection.createChannel(function (error1, channel) {
    if (error1) {
      throw error1;
    }

    var timestamp = new Date().getTime();
    var queue = "Queue-hello";
    var msg = `[${index}] [${timestamp}] Hello World!`;

    channel.assertQueue(queue, {
      durable: false,
    });

    channel.sendToQueue(queue, Buffer.from(msg));

    setTimeout(function () {
      channel.connection.close();
    }, 500);

    console.log(`[${index}] [${timestamp}] Sent %s`, msg);
  });
}

init();
