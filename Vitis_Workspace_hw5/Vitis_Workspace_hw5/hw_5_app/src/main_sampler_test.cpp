/*****************************************************************//**
 * @file main_sampler_test.cpp
 *
 * @brief Basic test of nexys4 ddr mmio cores
 *
 * @author p chu
 * @version v1.0: initial release
 *********************************************************************/

// #define _DEBUG
#include "chu_init.h"
#include "gpio_cores.h"
#include "sseg_core.h"
#include "i2c_core.h"



/**
 * uart transmits test line.
 * @note uart instance is declared as global variable in chu_io_basic.h
 */
void uart_check() {
   static int loop = 0;

   uart.disp("uart test #");
   uart.disp(loop);
   uart.disp("\n\r");
   loop++;
}


void sseg_check(SsegCore *sseg_p) {
   int i, n;
   uint8_t dp;

   //turn off led
   for (i = 0; i < 8; i++) {
      sseg_p->write_1ptn(0xff, i);
   }
   //turn off all decimal points
   sseg_p->set_dp(0x00);

   // display 0x0 to 0xf in 4 epochs
   // upper 4  digits mirror the lower 4
   for (n = 0; n < 4; n++) {
      for (i = 0; i < 4; i++) {
         sseg_p->write_1ptn(sseg_p->h2s(i + n * 4), 3 - i);
         sseg_p->write_1ptn(sseg_p->h2s(i + n * 4), 7 - i);
         sleep_ms(300);
      } // for i
   }  // for n
      // shift a decimal point 4 times
   for (i = 0; i < 4; i++) {
      bit_set(dp, 3 - i);
      sseg_p->set_dp(1 << (3 - i));
      sleep_ms(300);
   }
   //turn off led
   for (i = 0; i < 8; i++) {
      sseg_p->write_1ptn(0xff, i);
   }
   //turn off all decimal points
   sseg_p->set_dp(0x00);

}


/*
 * read temperature from adt7420
 * @param adt7420_p pointer to adt7420 instance
 */
float adt7420_check(I2cCore *adt7420_p, GpoCore *led_p) {
	   const uint8_t DEV_ADDR = 0x4b;
	   uint8_t wbytes[2], bytes[2];
	   //int ack;
	   uint16_t tmp;
	   float tmpC;

	   // read adt7420 id register to verify device existence
	   // ack = adt7420_p->read_dev_reg_byte(DEV_ADDR, 0x0b, &id);

	   wbytes[0] = 0x0b;
	   adt7420_p->write_transaction(DEV_ADDR, wbytes, 1, 1);
	   adt7420_p->read_transaction(DEV_ADDR, bytes, 1, 0);
	   uart.disp("read ADT7420 id (should be 0xcb): ");
	   uart.disp(bytes[0], 16);
	   uart.disp("\n\r");
	   //debug("ADT check ack/id: ", ack, bytes[0]);
	   // read 2 bytes
	   //ack = adt7420_p->read_dev_reg_bytes(DEV_ADDR, 0x0, bytes, 2);
	   wbytes[0] = 0x00;
	   adt7420_p->write_transaction(DEV_ADDR, wbytes, 1, 1);
	   adt7420_p->read_transaction(DEV_ADDR, bytes, 2, 0);

	   // conversion
	   tmp = (uint16_t) bytes[0];
	   tmp = (tmp << 8) + (uint16_t) bytes[1];
	   if (tmp & 0x8000) {
	      tmp = tmp >> 3;
	      tmpC = (float) ((int) tmp - 8192) / 16;
	   } else {
	      tmp = tmp >> 3;
	      tmpC = (float) tmp / 16;
	   }
	   uart.disp("temperature (C): ");
	   uart.disp(tmpC);
	   uart.disp("\n\r");
	   led_p->write(tmp);
	   sleep_ms(1000);
	   led_p->write(0);
   return tmpC;
}



void temp_display(float temp, SsegCore *sseg_p) {
		float temp_value;
		int tmp_display;

	   	int tmp_sseg[8];
	   	for (int x = 0; x < 9; x++)
	   	{
	   		tmp_sseg[x] = 0;
	   	}
	   	tmp_sseg[0] = 12;
	   	temp_value = temp;
	   	tmp_display = temp_value * 1000;
	   	for(int i=0; i<5; i++)
	   	{
	   		tmp_sseg[i+1] = tmp_display % 10;
	   		tmp_display = tmp_display / 10;
	   		uart.disp(tmp_sseg[i+1]);
	   		uart.disp("\n\r");
	   	}
	   	for (int i = 0; i <9; i++)
	   	{
	   		sseg_p->write_1ptn(sseg_p->h2s(tmp_sseg[i]), i);
	   	}
	   	sseg_p->set_dp(0x10);
}



GpoCore led(get_slot_addr(BRIDGE_BASE, S2_LED));
SsegCore sseg(get_slot_addr(BRIDGE_BASE, S8_SSEG));
I2cCore adt7420(get_slot_addr(BRIDGE_BASE, S10_I2C));



int main() {
   float temp_value;
   int tmp_display;

   	int tmp_sseg[8];
   	for (int x = 0; x < 9; x++)
   	{
   		tmp_sseg[x] = 0;
   	}
   	tmp_sseg[0] = 12;
   temp_value=adt7420_check(&adt7420, &led);
   tmp_display = temp_value * 1000;
   for(int i=0; i<5; i++)
   	{
   		tmp_sseg[i+1] = tmp_display % 10;
   		tmp_display = tmp_display / 10;
   		uart.disp(tmp_sseg[i]);
   		uart.disp("\n\r");
   	}
   for (int i = 0; i <9; i++)
   {
	   sseg.write_1ptn(sseg.h2s(tmp_sseg[i]), i);
   }
   sseg.set_dp(0x10);
   while (1) {
	  temp_value=adt7420_check(&adt7420, &led);
	  sleep_ms(10);
      temp_display(temp_value, &sseg);
      sleep_ms(500);
   } //while
} //main

