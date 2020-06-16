from tabletext import to_text
import uhal
import binascii
from math import pow
from time import sleep
import logging
__author__ = "Antonio Bergnoli", "Davide Pedretti"
__copyright__ = "Copyright 2017, INFN, LNL"
__credits__ = []
__license__ = "GPL"
__version__ = "0.0.1"
__maintainer__ = "Antonio Bergnoli"
__email__ = "antonio.bergnoli@dwave.it"
__status__ = "Developement"


class GCU():
    """Base class for interact with GCU via IPbus"""

    def __init__(self, uhal_connection):
        """
        initialize and check IPBUS connection
        """
        self.hw = uhal_connection
        self.connection_status = "IPBUS Not connected"
        try:
            self.hw.getNode("ipbus_fifo_2.ctrl").read()
            self.hw.dispatch()
            self.connection_status = "IPBUS Connection OK"
        except:
            print "GCU Not connected,\
            not configured or wrong IP in connection file"

        # logging configuration facility
        self.i2c_configured = False

        self.logger = logging.getLogger()
        self.log_handler = logging.StreamHandler()
        self.log_formatter = logging.Formatter(
            '%(asctime)s %(name)-12s %(levelname)-8s %(message)s')
        self.log_handler.setFormatter(self.log_formatter)
        self.logger.addHandler(self.log_handler)
        self.logger.setLevel(logging.DEBUG)

    def check_FMC_init_done(self, max_attempt=100):
        """
        check FMC initialization status
        """
        fmc_init_done = False
        attempt = 0
        retval = False
        while not fmc_init_done and attempt != max_attempt:
            read_val = self.hw.getNode(
                "cs_read.status.fmc_init_done").read()
            try:
                self.hw.dispatch()
                fmc_init_done = read_val.value()
            except:
                print "retry IPBUS transaction"
            attempt += attempt
        if fmc_init_done:
            retval = True
        else:
            retval = False
        return retval

    def set_trigger_window(self, window=0x200):
        retval = False
        try:
            self.hw.getNode("cs_write.trigger_window").write(window)
            self.hw.dispatch()
            retval = True
        except:
            print "retry IPBUS transaction"
        return retval

    def set_trigger_threshold(self, threshold=0x1000):
        retval = False
        try:
            self.hw.getNode("cs_write.trigger_threshold").write(threshold)
            self.hw.dispatch()
            retval = True
        except:
            print "retry IPBUS transaction"
        return retval

    def select_ADC(self, adcnum=0):
        retval = False
        try:
            self.hw.getNode("cs_write.adc_sel").write(adcnum)
            self.hw.dispatch()
            retval = True
        except:
            print "retry IPBUS transaction"
        return retval
        pass

    def enable_acquisition(self):
        retval = False
        try:
            self.hw.getNode("cs_write.command").write(0x00010001)
            self.hw.dispatch()
            retval = True
        except:
            print "retry IPBUS transaction"
        return retval
        pass

    def disable_acquisition(self):
        retval = False
        try:
            self.hw.getNode("cs_write.command").write(0x0000000)
            self.hw.dispatch()
            retval = True
        except:
            print "retry IPBUS transaction"
        return retval
        pass

    def configure_i2c_interface(self):
        self.hw.getNode("i2c_master.prerl").write(0x80)   # PRESCALER byte0
        self.hw.getNode("i2c_master.prerh").write(0x00)   # PRESCALER byte1
        self.hw.getNode("i2c_master.ctrl").write(0x80)    # I2C core enabled
        self.hw.dispatch()
        self.i2c_configured = True

    def read_manufacturer_id(self, chip_num=1):
        if chip_num == 1:
            # MAX1617A chip 1 - read manufacturer ID:
            # slave address + write bit
            self.hw.getNode("i2c_master.tx").write(0x30)
            # START + enable WRITE to slave
            self.hw.getNode("i2c_master.command").write(0x90)
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer is in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            # manufacturer ID address + write bit
            self.hw.getNode("i2c_master.tx").write(0xfe)
            # enable WRITE to slave
            self.hw.getNode("i2c_master.command").write(0x10)
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer is in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            # slave address + read bit
            self.hw.getNode("i2c_master.tx").write(0x31)
            # START + WRITE TX value to slave
            self.hw.getNode("i2c_master.command").write(0x90)
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer is in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
                    # issue a read command + STOP bit
            self.hw.getNode("i2c_master.command").write(0x28)
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer is in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1

            manufacturer_ID_chip = self.hw.getNode("i2c_master.rx").read()
            self.hw.dispatch()
        elif chip_num == 2:
            # MAX1617A chip 2 - read manufacturer ID:
            self.hw.getNode("i2c_master.tx").write(
                0x98)        # slave address + write bit
            self.hw.getNode("i2c_master.command").write(
                0x90)   # START + enable WRITE to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer is in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            # manufacturer ID address + write bit
            self.hw.getNode("i2c_master.tx").write(0xfe)
            self.hw.getNode("i2c_master.command").write(
                0x10)  # enable WRITE to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer is in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1

            self.hw.getNode("i2c_master.tx").write(
                0x99)       # slave address + read bit
            self.hw.getNode("i2c_master.command").write(
                0x90)  # START + WRITE TX value to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer is in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1

            self.hw.getNode("i2c_master.command").write(
                0x28)  # issue a read command + STOP bit
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer is in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1

            manufacturer_ID_chip = self.hw.getNode("i2c_master.rx").read()
            self.hw.dispatch()
        return manufacturer_ID_chip.value()

    def read_device_id(self, chip_num=0):

        if chip_num == 1:
            # MAX1617A chip 1 - read device ID:
            self.hw.getNode("i2c_master.tx").write(
                0x30)        # slave address + write bit
            self.hw.getNode("i2c_master.command").write(
                0x90)   # START + enable WRITE to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer is in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            self.hw.getNode("i2c_master.tx").write(
                0xff)    # device ID address + write bit
            self.hw.getNode("i2c_master.command").write(
                0x10)  # enable WRITE to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer is in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            self.hw.getNode("i2c_master.tx").write(
                0x31)       # slave address + read bit
            self.hw.getNode("i2c_master.command").write(
                0x90)  # START + WRITE TX value to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer is in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            self.hw.getNode("i2c_master.command").write(
                0x28)  # issue a read command + STOP bit
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer is in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            device_ID = self.hw.getNode("i2c_master.rx").read()
            self.hw.dispatch()
        elif (chip_num == 2):
            # MAX1617A chip 2 - read device ID:
            self.hw.getNode("i2c_master.tx").write(
                0x98)        # slave address + write bit
            self.hw.getNode("i2c_master.command").write(
                0x90)   # START + enable WRITE to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer is in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            self.hw.getNode("i2c_master.tx").write(
                0xff)    # device ID address + write bit
            self.hw.getNode("i2c_master.command").write(
                0x10)  # enable WRITE to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer is in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            self.hw.getNode("i2c_master.tx").write(
                0x99)       # slave address + read bit
            self.hw.getNode("i2c_master.command").write(
                0x90)  # START + WRITE TX value to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer is in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1

            self.hw.getNode("i2c_master.command").write(
                0x28)  # issue a read command + STOP bit
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer is in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            device_ID = self.hw.getNode("i2c_master.rx").read()
        return device_ID

    def get_temepratures(self, chip_num=1):
        if chip_num == 1:
            # MAX1617A chip 1 - read local temperature:
            self.hw.getNode("i2c_master.tx").write(
                0x30)        # slave address + write bit
            self.hw.getNode("i2c_master.command").write(
                0x90)   # START + enable WRITE to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            # local temperature address + write bit
            self.hw.getNode("i2c_master.tx").write(0x00)
            self.hw.getNode("i2c_master.command").write(
                0x10)  # enable WRITE to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            self.hw.getNode("i2c_master.tx").write(
                0x31)       # slave address + read bit
            self.hw.getNode("i2c_master.command").write(
                0x90)  # START + WRITE TX value to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer in progress
                tip = self.hw.getNode("i2c_master.status").read()
            self.hw.dispatch()
            if tip == 0x00000000:
                i = 1
            self.hw.getNode("i2c_master.command").write(
                0x28)  # issue a read command + STOP bit
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            local_temp_chip = self.hw.getNode("i2c_master.rx").read()
            self.hw.dispatch()

            # MAX1617A chip 1 - read external temperature:
            self.hw.getNode("i2c_master.tx").write(
                0x30)        # slave address + write bit
            self.hw.getNode("i2c_master.command").write(
                0x90)   # START + enable WRITE to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            # external temperature address + write bit
            self.hw.getNode("i2c_master.tx").write(0x01)
            self.hw.getNode("i2c_master.command").write(
                0x10)  # enable WRITE to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            self.hw.getNode("i2c_master.tx").write(
                0x31)       # slave address + read bit
            self.hw.getNode("i2c_master.command").write(
                0x90)  # START + WRITE TX value to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            self.hw.getNode("i2c_master.command").write(
                0x28)  # issue a read command + STOP bit
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            external_temp_chip = self.hw.getNode("i2c_master.rx").read()
            self.hw.dispatch()

        elif chip_num == 2:
            # MAX1617A chip 2 - read local temperature:
            self.hw.getNode("i2c_master.tx").write(
                0x98)        # slave address + write bit
            self.hw.getNode("i2c_master.command").write(
                0x90)   # START + enable WRITE to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            # local temperature address + write bit
            self.hw.getNode("i2c_master.tx").write(0x00)
            self.hw.getNode("i2c_master.command").write(
                0x10)  # enable WRITE to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            self.hw.getNode("i2c_master.tx").write(
                0x99)       # slave address + read bit
            self.hw.getNode("i2c_master.command").write(
                0x90)  # START + WRITE TX value to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            self.hw.getNode("i2c_master.command").write(
                0x28)  # issue a read command + STOP bit
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            local_temp_chip = self.hw.getNode("i2c_master.rx").read()
            # MAX1617A chip 2 - read external temperature:
            self.hw.getNode("i2c_master.tx").write(
                0x98)        # slave address + write bit
            self.hw.getNode("i2c_master.command").write(
                0x90)   # START + enable WRITE to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1
            # external temperature address + write bit
            self.hw.getNode("i2c_master.tx").write(0x01)
            self.hw.getNode("i2c_master.command").write(
                0x10)  # enable WRITE to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1

            self.hw.getNode("i2c_master.tx").write(
                0x99)       # slave address + read bit
            self.hw.getNode("i2c_master.command").write(
                0x90)  # START + WRITE TX value to slave
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1

            self.hw.getNode("i2c_master.command").write(
                0x28)  # issue a read command + STOP bit
            self.hw.dispatch()
            i = 0
            while i < 1:    # wait transfer in progress
                tip = self.hw.getNode("i2c_master.status").read()
                self.hw.dispatch()
                if tip == 0x00000000:
                    i = 1

            external_temp_chip = self.hw.getNode("i2c_master.rx").read()
            self.hw.dispatch()
        return {'local': local_temp_chip.value(),
                'external': external_temp_chip.value()}

    def display_registers(self):

        status = self.hw.getNode("cs_read.status").read()
        locked_tx = self.hw.getNode("cs_read.status.locked_tx").read()
        locked_rx = self.hw.getNode("cs_read.status.locked_rx").read()
        ttc_tx_ready = self.hw.getNode("cs_read.status.ttc_tx_ready").read()
        ttc_rx_ready = self.hw.getNode("cs_read.status.ttc_rx_ready").read()
        no_errors = self.hw.getNode("cs_read.status.no_errors").read()
        aligned = self.hw.getNode("cs_read.status.aligned").read()
        ddr3_init_done = self.hw.getNode(
            "cs_read.status.ddr3_init_done").read()
        tdc_intb = self.hw.getNode("cs_read.status.tdc_intb").read()
        ddr3_tg_compare_error = self.hw.getNode(
            "cs_read.status.ddr3_tg_compare_error").read()
        ddr3_power_good = self.hw.getNode(
            "cs_read.status.ddr3_power_good").read()
        fmc_init_done = self.hw.getNode("cs_read.status.fmc_init_done").read()
        table = []
        self.hw.dispatch()
        table.append(["REGISTER bits", "Value"])
        table.append(["status", hex(status.value())])
        table.append(["locked_tx", locked_tx.value()])
        table.append(["locked_rx", locked_rx.value()])
        table.append(["ttc_tx_ready", ttc_tx_ready.value()])
        table.append(["ttc_rx_ready", ttc_rx_ready.value()])
        table.append(["no_errors", no_errors.value()])
        table.append(["aligned", aligned.value()])
        table.append(["ddr3_init_done", ddr3_init_done.value()])
        table.append(["ddr3_power_good", ddr3_power_good.value()])
        table.append(["ddr3_tg_compare_error", ddr3_tg_compare_error.value()])
        table.append(["tdc_intb", tdc_intb.value()])
        table.append(["fmc_init_done", fmc_init_done.value()])
        print to_text(table)

    def display_temperatures(self):
        t_chip1 = self.get_temepratures(chip_num=1)
        t_chip2 = self.get_temepratures(chip_num=2)
        table = []
        table.append(["Chip 1", t_chip1['Internal'], t_chip1['External']])
        table.append(["Chip 2", t_chip2['Internal'], t_chip2['External']])
        print to_text(table)

    def set_pre_trigger(self, value):
        self.hw.getNode("data_assembly.pre_trigger").write(value)
        self.hw.dispatch()

    def set_sample_count(self, value):
        self.hw.getNode("data_assembly.sample_count").write(value)
        self.hw.dispatch()

    def acquire_fifo_lock(self):
        """
        acquire the lock on the 2 stage fifo
        """
        self.hw.getNode("ipbus_fifo_2.ctrl").write(1)

    def release_fifo_lock(self):
        """
        release the lock on the 2 stage fifo
        """
        self.hw.getNode("ipbus_fifo_2.ctrl").write(0)

    def try_dispatch(self):
        """
        execute a uhal dispatch in a try/except
        """
        try:
            self.hw.dispatch()
        except:
            self.logger.debug("Bad connection to ipbus target")

    def get_fifo_count(self):
        """
        return the count (uhal object) of valid data
        read cycle from ipbus daq fifo
        """
        count = self.hw.getNode("ipbus_fifo_2.status.count").read()
        return count

    def read_from_daq_fifo(self, size):
        """
        read from ipbus daq fifo <size> elements
        """
        fifo = self.hw.getNode("ipbus_fifo_2.data").readBlock(size)
        return fifo

    def get_fifo_occupation(self):
        """
        get the current fifo occupation
        """
        occupied = self.hw.getNode("ipbus_fifo_2.occupied").read()
        return occupied

    def get_fifo_control(self):
        """
        get the control register value
        """
        control = self.hw.getNode("ipbus_fifo_2.ctrl").read()
        return control

    # UART section

    rx_data_valid_mask = 0x00000100
    rx_data_mask = 0x000000ff

    def set_uart_baudrate(self, prescaler=543):
        self.hw.getNode("uart.setup.clks").write(prescaler)
        return True

    def set_uart_parity_bit(self, parity=False):
        if parity:
            self.hw.getNode("uart.setup.parity").write(0x1)
        else:
            self.hw.getNode("uart.setup.parity").write(0x0)

    def set_uart_stop_bit(self, stop_bit_n=1):
        if stop_bit_n == 1:
            self.hw.getNode("uart.setup.stop").write(0)
        else:
            print "stop bit number Not implemented"
            return False

    def set_uart_n_word_bits(self, n=8):
        if (n > 2 and n < 9):
            self.hw.getNode("uart.setup.word").write(8 - n)
        else:
            print " Value not allowed"
            return False

    def uart_reset_receiver(self):
        self.hw.getNode("uart.rx_data.rx_reset").write(1)

    def uart_clear_receiver_error(self):
        self.hw.getNode("uart.rx_data.clear").write(0x3)

    def uart_display_fifo_level(self):
        rx_fifo_fill = self.hw.getNode("uart.fifo.rx_fifo_fill").read()
        self.hw.dispatch()
        print "rx fifo fill level: "
        print rx_fifo_fill.value()
        setup = self.hw.getNode("uart.setup").read()
        self.hw.dispatch()
        print "setup: %d" % setup.value()
        hv_gpi = self.hw.getNode("cs_read.status.hv_int").read()
        self.hw.dispatch()
        print "hv module interrupt: %d" % hv_gpi.value()
        lgln = self.hw.getNode("uart.fifo.rx_fifo_lgln").read()
        self.w.dispatch()
        print "rx fifo lenght: %d" % lgln.value()

    def uart_send_string(self, current_string):
        for c in current_string:
            self.hw.getNode("uart.tx_data").write(ord(c))
        sleep(1)

    def uart_read(self):
        i = 0
        while i == 0:
            no_empty = self.hw.getNode("uart.fifo.rx_fifo_not_empty").read()
            rx_fifo_fill = self.hw.getNode("uart.fifo.rx_fifo_fill").read()
            hw.dispatch()
            if no_empty == 1:
                print "rx fifo fill level: %d" % rx_fifo_fill.value()
                i = 1
        while rx_fifo_fill.value() > 0:
            rx_data = hw.getNode("uart.rx_data").read()
            hw.dispatch()
            rword = rx_data_mask & rx_data
            data_valid = rx_data_valid_mask & rx_data
            if data_valid == 0:
                print(chr(rword))
            else:
                print "error"
            rx_fifo_fill = hw.getNode("uart.fifo.rx_fifo_fill").read()
            hw.dispatch()
            print "rx fifo fill level: %d" % rx_fifo_fill.value()
