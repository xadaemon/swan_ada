#ifndef SWAN_H
#define SWAN_H

struct pid_;
typedef struct pid_ swan_pid_t;

extern swan_pid_t *pid_init();
extern void pid_free(swan_pid_t *controller);

extern void pid_set_gains(swan_pid_t *controller, double kp, double kd, double ki);
extern void pid_set_point(swan_pid_t *controller, double sp);
extern double pid_tick(swan_pid_t *controller, double pv, double dt);

#endif /* SWAN_H */