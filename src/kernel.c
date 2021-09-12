static char * const VGA_MEMORY=(char *) 0xb8000;
static const int VGA_WIDTH=80;
static const int VGA_HEIGHT=25;

void kernel_early(void){
	/*
	 *Kernel code
	 * */
}


int main(void){

	const char *str = "Hello world";

	unsigned int i = 0; //holding position for the text;
	unsigned int j=  0;//holding position in the buffer	  

	while(str[i]!='\0'){

		VGA_MEMORY[j]=str[i];
		VGA_MEMORY[j+1] = 0x04;
		i++;

		j=j+2;

	}
	return 0;
}
