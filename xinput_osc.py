import math
from cmath import polar

#Setup Controller Block
from XInput import get_connected, get_events, get_thumb_values, get_state
get_connected()

#OSC Builder Logic Block
from pythonosc import udp_client
sender = udp_client.SimpleUDPClient('127.0.0.1', 4560)

prev_left_stick_input=[0,0]

while True:
    event_list = get_events()
    for event in event_list: #3 = press, 4 = release, 5 = analogue trigger, 6 = stick
        if event.type == 3:
            if event.button == "A":
                sender.send_message('/trigger/mainloop', 1)
            elif event.button == "B":
                sender.send_message('/trigger/burst2', 1)
            elif event.button == "X":
                sender.send_message('/trigger/burst3', 1)
            elif event.button == "Y":
                sender.send_message('/trigger/burst1', 1)
            elif event.button == "LEFT_SHOULDER":
                x,y=get_thumb_values(get_state(0))[0]
                coords = complex(x,y)
                amplitude, angle_rad = polar(coords)
                angle = angle_rad/math.pi*180
                if amplitude == 0:
                    amplitude, angle = prev_left_stick_input
                else:
                    prev_left_stick_input=amplitude,angle
                if 67.5 < angle < 112.5:
                    sender.send_message('/trigger/top', amplitude)
                elif 22.5 < angle < 67.5:
                    sender.send_message('/trigger/topright', amplitude)
                elif -22.5 < angle < 22.5:
                    sender.send_message('/trigger/right', amplitude)
                elif -22.5 > angle > -67.5:
                    sender.send_message('/trigger/bottomright', amplitude)
                elif -112.5 < angle < -67.5:
                    sender.send_message('/trigger/bottom', amplitude)
                elif -157.5 < angle < -112.5:
                    sender.send_message('/trigger/bottomleft', amplitude)
                elif 157.5 < angle < 180 or -157.5 > angle > -180:
                    sender.send_message('/trigger/left', amplitude)
                elif 112.5 < angle < 157.5:
                    sender.send_message('/trigger/topleft', amplitude)
                else:
                    print(angle)
                """if event.state:
                    print("left joy y" +str(self.LeftJoystickY))
                    print("left joy x" +str(self.LeftJoystickX))
                    print("angle: " +str(angle))
                    if self.LeftJoystickY>0.4 and not self.LeftJoystickX<-0.4 and not self.LeftJoystickX>0.4:
                        sender.send_message('/trigger/top', amplitude)
                    elif self.LeftJoystickY>0.4 and self.LeftJoystickX<-0.4:
                        sender.send_message('/trigger/topleft', amplitude)"""
            else:
                print(event.button)
            """A 4096
            B 8192
            X 16384
            Y 32768
            LT 256
            RT 512
            Start 16
            Select 32
            Left 4
            Up 1
            Down 2
            Right 8
            LStickPress 64
            RStickPress 128"""
