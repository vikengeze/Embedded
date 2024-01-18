#include <linux/kernel.h>

asmlinkage long sys_greet(void)
{
	printk(KERN_ALERT "Greetings from kernel and team no. 35\n");
	return 0;
}