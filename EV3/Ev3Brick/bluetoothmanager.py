from pybricks.hubs import EV3Brick
from pybricks.messaging import TextMailbox, BluetoothMailboxClient


class BluetoothManager:
    @staticmethod
    def listen_to_message() -> str:
        ev3 = EV3Brick()
        ev3.speaker.beep()

        SERVER = 'DESKTOP-PR2SECF'
        client = BluetoothMailboxClient()
        mbox = TextMailbox('greeting', client)

        try:
            print('establishing connection...')
            client.connect(SERVER)
            print('connected!')

            # In this program, the client sends the first message and then waits for the
            # server to reply.
            mbox.send('hello!')
            print('send hello')

            mbox.wait()
            print('wait done')

            message_received = mbox.read()
            print("Message received: ", message_received)
        except Exception as e:
            print("An error occurred:", e)

        print('all good')
        message_received = 'k'
        return message_received
