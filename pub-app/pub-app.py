import pika
import random
from datetime import datetime
import asyncio

async def produce_numbers(channel):
    while True:
        random_number = random.randint(1, 5)
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        print(f"{timestamp} Published number: {random_number}")
        channel.basic_publish(exchange='', routing_key='proba-feladat',
                              body=f"{timestamp} {random_number}")
        await asyncio.sleep(5)

if __name__ == '__main__':
    connection_parameters = pika.ConnectionParameters(
        host="10.43.107.239", # this shouldn't be hardcoded
        virtual_host="fph",
        credentials=pika.PlainCredentials("admin", "admin")) # this most definitely shouldn't be hardcoded - use k8s secrets instead
    connection = pika.BlockingConnection(connection_parameters)
    channel = connection.channel()

    asyncio.run(produce_numbers(channel))