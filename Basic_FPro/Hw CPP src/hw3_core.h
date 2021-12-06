/*****************************************************************//**
 * @file gpio_cores.h
 *
 * @brief Contain classes of simple i/o related cores
 *
 * Detailed description:
 *
 * @author p chu
 * @version v1.0: initial release
 ********************************************************************/

#ifndef _hw3_H_INCLUDED
#define _hw3_H_INCLUDED

#include "chu_init.h"

/**********************************************************************
 * gpi (general-purpose input) core driver
 **********************************************************************/
/**
 * gpi (general-purpose input) core driver
 *  - retrieve data from MMIO gpi core.
 *
 * MMIO subsystem HDL parameter:
 *  - W (not used in driver): # bits of input register
 *   (unused bits return 0's)
 */
class HW3Core {
public:
   /**
    * register map
    *
    */
   enum {
      BLINK0_REG = 0 /**< Blink rate for LED 12 in ms */
	  BLINK1_REG = 0 /**< Blink rate for LED 13 */
	  BLINK2_REG = 0 /**< Blink rate for LED 14 */
	  BLINK3_REG = 0 /**< Blink rate for LED 15 */
   };
   /**
    * constructor.
    *
    */
   HW3Core(uint32_t core_base_addr);
   ~HW3Core();                  // not used


   void write(uint32_t timer, uint32_t data);

private:
   uint32_t base_addr;
   uint32_t wr_data;      // same as GPO core data reg
};





#endif  // _HW3_H_INCLUDED
