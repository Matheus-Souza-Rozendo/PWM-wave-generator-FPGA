/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include "alt_types.h"
#include "system.h"
#include "altera_avalon_pio_regs.h"

const alt_u32 frequencia_sistema = 50000000;
const alt_u16 OVERFLOW = 65535;

alt_u16 calcula_max(alt_u8 div10, alt_32 frequencia_pwm) {
	alt_32 result = (frequencia_sistema / (frequencia_pwm * (1 << div10))) - 1;
    if(result>OVERFLOW){
        return 0;
    }
    return result;
}

void atualizaFrequenciaPWM(alt_32 *reffrequencia_pwm, alt_u16 *refmax){
	alt_u8 i = 0;
    alt_u16 maior = calcula_max(i,*reffrequencia_pwm);
    alt_u8 index_maior = i;
    for(i=1;i<8;i++){
    	alt_u16 valor_max = calcula_max(i,*reffrequencia_pwm);
         if(valor_max > maior){
             maior=valor_max;
             index_maior = i;
         }
    }
    *refmax=maior;
    //printf("Escrevendo no PIO do Max: %d\n",*refmax);
    IOWR_ALTERA_AVALON_PIO_DATA(PINO_MAX_BASE,*refmax);
    //printf("Escrevendo no PIO do div10: %d\n\n",index_maior);
    IOWR_ALTERA_AVALON_PIO_DATA(PINO_DIV_BASE,index_maior);
    return;
}

void atualizaDutyCicle(alt_u16 *refDutyCicle,alt_u16 *refmax ){
    if ( (*refDutyCicle) > (*refmax + 1) ){
        *refDutyCicle=*refmax+1;
    }
    //printf("\n\nEscrevendo no PIO do DutyCicle: %hu\n\n",*refDutyCicle);
    IOWR_ALTERA_AVALON_PIO_DATA(PINO_D_BASE,*refDutyCicle);
    return;
}

int main()
{
	alt_32 frequencia_pwm = 10000;
	alt_u16 max,DutyCicle;
	DutyCicle=2000;
	printf("Iniciando...\n\n"); 
	atualizaFrequenciaPWM(&frequencia_pwm,&max);
	atualizaDutyCicle(&DutyCicle,&max);
	while(1) {
		printf("\n\nDigite a opcao desejada:\n"); 
		printf("1 - Atualizar DutyCicle\n");
		printf("2 - Atualizar Frequencia do PWM\n");
		printf("opcao:");
		alt_8 opcao;
		scanf(" %c",&opcao);// mudar para contexto do NIOS2
		if(opcao=='1') {
			printf("\ndigite o valor do DutyCicle - 0 at� %hu\n valor:",max+1);// mudar para o contexto no NIOS2
			scanf("%hd",&DutyCicle);// mudar para contexto do NIOS2
            atualizaDutyCicle(&DutyCicle,&max);
		}else{
		    if(opcao=='2'){
		        printf("\ndigite o valor da Frequencia PWM (em hz) - Valor maximo de %d Hz\nvalor:",frequencia_sistema);// mudar para o contexto no NIOS2
			    scanf("%d",&frequencia_pwm);// mudar para contexto do NIOS2
			    atualizaFrequenciaPWM(&frequencia_pwm,&max);
				atualizaDutyCicle(&DutyCicle,&max);
		    }
		}
	}
	return 0;
}
