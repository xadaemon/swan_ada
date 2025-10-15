#include <stdio.h>
#include <unistd.h>
#include "swan_ada.h"

int main(int argc, char **argv) {
	swan_pid_t *pid = pid_init();
	pid_set_gains(pid, 1, 0, 0);
	pid_set_point(pid, 5.0);
	double point = 2.0;
	double pv = 0.0;
	printf("here\n");
	while(1) {
		printf("%lf\n", point);
		pv = pid_tick(pid, point, 0.16);
		printf("%lf\n", pv);
		sleep(1);
	}

	return 0;
}
