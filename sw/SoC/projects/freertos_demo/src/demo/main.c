
#include "FreeRTOS.h"
#include "task.h"

#define TASK1_PRIORITY (tskIDLE_PRIORITY + 1)
#define TASK2_PRIORITY (tskIDLE_PRIORITY + 1)

#define TASK1_PARAMETER (1)
#define TASK2_PARAMETER (2)

static void Task1(void *pvParameters) {

    uint32_t a = 0;
    uint32_t b = 0;
    configASSERT( ( ( uint32_t ) pvParameters ) == 1 );

    while (1) {
    
    	a=b+(uint32_t)pvParameters;
        __asm("ebreak");
        taskYIELD();
        
    }
}

static void Task2(void *pvParameters) {

    uint32_t a = 0;
    uint32_t b = 3;
    configASSERT( ( ( uint32_t ) pvParameters ) == 2 );

    while (1) {
    
	    a=b-(uint32_t)pvParameters;
	    __asm("ebreak");
	    taskYIELD();
	    
   } 
    
}

void vAssertCalled(const char *file, int line) {
    __asm("ebreak");
}

int main(){

    /* Insert your code here */
    
    xTaskCreate(Task1,"Task1", configMINIMAL_STACK_SIZE,
			(void *)TASK1_PARAMETER,
			TASK1_PRIORITY,
			NULL);

    xTaskCreate(Task2,"Task2", configMINIMAL_STACK_SIZE,
			(void *)TASK2_PARAMETER, TASK2_PRIORITY,
			NULL);
			    
    vTaskStartScheduler();

    configASSERT(0); //insufficient RAM->scheduler task returns->vAssertCalled() called
    
    while(1);

    return 0;
}
