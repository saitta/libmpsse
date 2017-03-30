libmpsse
========

Open source library for SPI/I2C control via FTDI chips

Libmpsse is a library for interfacing with SPI/I2C devices via FTDI's FT-2232 family of USB chips. Based around the libftdi library, it is written in C and includes a Python 3 wrapper courtesy of swig.

Key features of libmpsse are:
* python3
* SPI and I2C master mode operations
* Full support for SPI modes 0 and 2 (partial support for modes 1 and 3)
* Simple API for both C and Python
* Control of up to 12 GPIO pins (4 input/output, 8 others output only)
* Supports full bitbang mode
* Clock speeds of up to 30MHZ
* Data transfer speeds of better than 1MB/s are possible
* Libmpsse supports FTDI chips that contain an MPSSE engine, such as the FT-2232H and the FT-232H.

This is a fork of [devttys0/libmpsse](https://github.com/devttys0/libmpsse) Copyright (c) 2015, Craig Heffner

Original install documentation is in file docs/INSTALL


### Install example
```bash
apt install swig libftdi-dev python3-dev
PYLIB=/usr/local/lib/python3.5/dist-packages PYDEV=/usr/include/python3.5 ./configure
make
sudo make install
```

### Usage example

```python
    io = MPSSE(None)
    io.Open(0x0403, 0x6010, SPI0, frequency=1000000, endianess=MSB, interface=IFACE_A, description=None, serial=None, index=0)

    b_ch = MPSSE(None)
    b_ch.Open(0x0403, 0x6010, GPIO, interface=IFACE_B, description=None, serial=None, index=0)

    b_ch.PinHigh(CS3)
    time.sleep(0.5)

    io.Start()
    b_ch.PinLow(CS3)
    io.Write(bytes([1, 9]))
    b_ch.PinHigh(CS3)
    io.Stop()
```

