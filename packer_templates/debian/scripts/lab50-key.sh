#!/bin/bash

set -e

LAB50_KEY='-----BEGIN PGP PUBLIC KEY BLOCK-----

mQINBFJVT04BEAC+wggtOQAaYWw2GcCW/VYfvCeBf4wKSkfMI6UxDKBgMJyw6J7Z
mHyQ6daPi1HOOKZxmGf3d+26ouj9UaROyr632r3P9KlIkt7GerROoZNiONxtU3zS
9XhRi8VjzQBfznIlp3ixB9BO0BxwdxAR0t83fcnnRxplv84wFWLNtJs01/gnPzSb
t3OBI20g99+StD9rmT4cLsNWsOcpFly0QPuix3lQQom4Lb5MD+6Bo7rwX+PrPvdH
7GKAyk346LFZzNKK8FjiWxeaXQx+so0PoPnOHgCIzepIB8/WLZ6mj/VFcFjdBuRC
w9T1xd0W1pWUsS8oXZe91D69Op1t/4jOcvG00T98PR8kHEH89jscNBxH8uqfnVvO
Ke/7B4vyYDipyCetBe0p0YH4fWlDxkBMY5ZT5flCc8CYJuHW2zEW/yz9i6qvQVdf
qbRoV8gWUyV7gelfuM4OjQa1eSy4YIYFmXiQASoJ60H61Aj9lP+fvwTTgvUcyGyI
yQsID7hd2M8WeLVrVLN4RRww3Nc8yr5wu3aryOiYdMMvKOebjEgTjWcRjXTzHFoA
wj/1gQGRDm2v4q8rUK1W/72L+Hmdgrur62lcPM3mjbbo2JxhLVLaiD6XrObEuoLo
VZL1Y7DonMEO0webpJbdygao/pQNJWKxPFnoGllwy5baY65BdOibFDw2JwARAQAB
tDBMYWJvcmF0b3J5IDUwIChBUFQgQXJjaGl2ZSBLZXkpIDx0ZWFtQGxhYjUwLm5l
dD6JAk8EEwECADkCGy8GCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAFiEE0MchE2r/
kxnc+CduqY3wvjGfrNoFAlrhmcEACgkQqY3wvjGfrNorfw/+Lagu1pd41kWL/Mv2
XOLJfO3ydMCm/UUPjQbSGFO0Ua1vhNvlwo9a/flU2fke4xK/cxTmz+zpApeHhxBk
D3qPxBpmEnj/fQubLVJIfKX2zr7KkMT9F6NyYA1mPVa6X6fiYKjCAKEHY/dyX08N
4EdAFlpyj3LEpeINJRrsN3Xn5BClAi5ii3fC6BBzFj14BqJZs+ayIvNGa0IKBCqM
K8t86SANQjx4t2/6b9CQW4Nw3ImWjiY9/ZWx/pubKBgAXtyJfUT/rKHHAXflXVUY
A6qWbUTElodNMDYlCLX+lh2jF5792QnHlgZ4tjxvKZ5RkcDDnwRO18GMSAHAEFfv
qw181Hi9KeHvHFhlyiIkGvILFYyl/bOG9AL5gjoMvik3MaLFIZco4E2sQk9k3CmI
sJX/aXQwqE6oOzt5aahgmqaCkQk5cEJ9TMwEfPf5RE4VtwySSQegXiwE4BBEIGUK
hrAHoHeD2ksOFPR6LnoLtW46+MPBixR9tMqLWcLM0HwIv5Zb9WcUB50rGA0C9mQw
Mji3yBKLYCjJY0yacPfjB1dF/spX1sdfSAXGooGOyfSGRq8zcWeGC5L+HBOyNhji
0/P4HRmznHSKMgiyZWqGBajhjlhR1y393WRXXiJmStE/IkbksRPds2ToY20idLEb
IO7Ma5TJzM8fWyb1qKni3EA4Dao=
=GwW1
-----END PGP PUBLIC KEY BLOCK-----'

echo "${LAB50_KEY}" | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/lab50.gpg