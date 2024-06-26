import struct
import enum
import serial
import time


def printMessage(s):
    return ' '.join("{:02x}".format(c) for c in s)


class MessageType(enum.Enum):
    Text = 0
    Numeric = 1
    Logic = 2


def decodeMessage(s, msgType):
    payloadSize = struct.unpack_from('<H', s, 0)[0]

    if payloadSize < 5:  # includes the mailSize
        raise BufferError('Payload size is too small')

    a, b, c, d = struct.unpack_from('<4B', s, 2)
    if a != 1 or b != 0 or c != 0x81 or d != 0x9e:
        raise BufferError('Header is not correct.  Expecting 01 00 81 9e')

    mailSize = struct.unpack_from('<B', s, 6)[0]

    if payloadSize < (5 + mailSize):  # includes the valueSize
        raise BufferError('Payload size is too small')

    mailBytes = struct.unpack_from('<' + str(mailSize) + 's', s, 7)[0]
    mail = mailBytes.decode('ascii')[:-1]

    valueSize = struct.unpack_from('<H', s, 7 + mailSize)[0]
    if payloadSize < (7 + mailSize + valueSize):  # includes the valueSize
        raise BufferError('Payload size does not match the packet')

    if msgType == MessageType.Logic:
        if valueSize != 1:
            raise BufferError('Value size is not one byte required for Logic Type')
        valueBytes = struct.unpack_from('<B', s, 9 + mailSize)[0]
        value = True if valueBytes != 0 else False
    elif msgType == MessageType.Numeric:
        if valueSize != 4:
            raise BufferError('Value size is not four bytes required for Numeric Type')
        value = struct.unpack_from('<f', s, 9 + mailSize)[0]
    else:
        valueBytes = struct.unpack_from('<' + str(valueSize) + 's', s, 9 + mailSize)[0]
        value = valueBytes.decode('ascii')[:-1]
        remnant = None
        if len(s) > (payloadSize + 2):
            remnant = s[(payloadSize) + 2:]

    return (mail, value, remnant)


def encodeMessage(msgType, mail, value):
    mail = mail + '\x00'
    mailBytes = mail.encode('ascii')
    mailSize = len(mailBytes)
    fmt = '<H4BB' + str(mailSize) + 'sH'

    if msgType == MessageType.Logic:
        valueSize = 1
        valueBytes = 1 if value is True else 0
        fmt += 'B'
    elif msgType == MessageType.Numeric:
        valueSize = 4
        valueBytes = float(value)
        fmt += 'f'
    else:
        value = value + '\x00'
        valueBytes = value.encode('ascii')
        valueSize = len(valueBytes)
        fmt += str(valueSize) + 's'

    payloadSize = 7 + mailSize + valueSize
    s = struct.pack(fmt, payloadSize, 0x01, 0x00, 0x81, 0x9e, mailSize, mailBytes, valueSize, valueBytes)
    return s


def send_message_to_ev3(message):
    EV3 = serial.Serial('/dev/rfcomm0')
    s = encodeMessage(MessageType.Text, 'abc', message)
    EV3.write(s)
    time.sleep(1)
    EV3.close()
