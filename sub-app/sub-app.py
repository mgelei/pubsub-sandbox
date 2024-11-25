import datetime
import pika

def callback(ch, method, properties, body):
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"Received {body} at {timestamp}")

if __name__ == '__main__':
    connection_parameters = pika.ConnectionParameters(
        host="10.43.107.239", # this shouldn't be hardcoded
        virtual_host="fph",
        credentials=pika.PlainCredentials("admin", "admin")) # this most definitely shouldn't be hardcoded - use k8s secrets instead
    connection = pika.BlockingConnection(connection_parameters)
    channel = connection.channel()
    channel.queue_declare(queue='proba-feladat')
    channel.basic_consume(queue='proba-feladat', on_message_callback=callback, auto_ack=True)
    channel.start_consuming()