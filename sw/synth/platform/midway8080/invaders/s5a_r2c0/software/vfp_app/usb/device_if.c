/*
 * This file is produced automatically.
 * Do not modify anything in here by hand.
 *
 * Created from source file
 *   kern/device_if.m
 * with
 *   makeobjops.awk
 *
 * See the source file for legal information
 */

#include "bsd-wrap.h"

#include "sys/param.h"
#include "sys/queue.h"
#include "sys/kernel.h"
#include "sys/kobj.h"
#include "sys/bus.h"
#include "local/device_if.h"

static int null_shutdown(device_t dev)
{
    return 0;
}

static int null_suspend(device_t dev)
{
    return 0;
}

static int null_resume(device_t dev)
{
    return 0;
}

static int null_quiesce(device_t dev)
{
    return EOPNOTSUPP;
}

struct kobj_method device_probe_method_default = {
	&device_probe_desc, (kobjop_t) kobj_error_method
};

struct kobjop_desc device_probe_desc = {
	0, &device_probe_method_default
};

struct kobj_method device_identify_method_default = {
	&device_identify_desc, (kobjop_t) kobj_error_method
};

struct kobjop_desc device_identify_desc = {
	0, &device_identify_method_default
};

struct kobj_method device_attach_method_default = {
	&device_attach_desc, (kobjop_t) kobj_error_method
};

struct kobjop_desc device_attach_desc = {
	0, &device_attach_method_default
};

struct kobj_method device_detach_method_default = {
	&device_detach_desc, (kobjop_t) kobj_error_method
};

struct kobjop_desc device_detach_desc = {
	0, &device_detach_method_default
};

struct kobj_method device_shutdown_method_default = {
	&device_shutdown_desc, (kobjop_t) null_shutdown
};

struct kobjop_desc device_shutdown_desc = {
	0, &device_shutdown_method_default
};

struct kobj_method device_suspend_method_default = {
	&device_suspend_desc, (kobjop_t) null_suspend
};

struct kobjop_desc device_suspend_desc = {
	0, &device_suspend_method_default
};

struct kobj_method device_resume_method_default = {
	&device_resume_desc, (kobjop_t) null_resume
};

struct kobjop_desc device_resume_desc = {
	0, &device_resume_method_default
};

struct kobj_method device_quiesce_method_default = {
	&device_quiesce_desc, (kobjop_t) null_quiesce
};

struct kobjop_desc device_quiesce_desc = {
	0, &device_quiesce_method_default
};

