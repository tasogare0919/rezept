#! /bin/sh

aws sqs send-message-batch --queue-url $QUEUE_URL --entries file://entries.json
