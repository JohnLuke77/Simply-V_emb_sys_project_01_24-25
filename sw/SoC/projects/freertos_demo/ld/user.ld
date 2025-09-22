/*
    *** User-defined linker script ***

    If you want to extend the UninaSoC.ld script, place here your code.
    If you want to redefine your own linker script, remove the UninaSoC include.

*/

INCLUDE ../../common/UninaSoC.ld

_stack_size = 0x00000000000002000; /* 8k   */
_stack_end = _stack_start - _stack_size; /* decreasing stack */
__freertos_irq_stack_top = _stack_start;    /*  define only if configISR_STACK_SIZE_WORDS is not already defined in FreeRtosConfig.h  */
_heap_size = 0x0000000000000400; /* 1k   */
_heap_end = _stack_end;
_heap_start = _heap_end - _heap_size; /* heap symbols aligned to 64 */



SECTIONS{
	  
	  .bss _text_end :  /*  _text_end has been already aligned to 64 bits in UninaSoC.ld */
	  {
	     _bss_start = .;
	     *(.bss*);
	     . = ALIGN(64);
	     _bss_end = .;
	  } > BRAM
	  
	  .data : 
	  {
	     . = ALIGN(64);
	     _data_start = .;
	     *(.data*);
	     . = ALIGN(64);
	     _data_end = .;
	  } > BRAM
	  
	  .rodata : 
	  {
	     . = ALIGN(64);
	     _rodata_start = .;
	     *(.rodata*);
	     . = ALIGN(64);
	     _rodata_end = .;
	  } > BRAM
	  

      .heap _heap_start :
      {        
	. += _heap_size; 
			/* _heap_start (as _heap_size) is already aligned to 64 bits */
      } > BRAM

	  
      .stack _stack_end :
      {
      	. += _stack_size;
			 /* _stack_start (as _stack_size) is already aligned to 64 bits -- _stack_start is auto-generated in UninaSoC.ld */
      } > BRAM

}


