#
# Zhangqun Ming <north_sea@qq.com>
# Copyright (c) 2021 Seeed Studio
#
# MIT License
#

SRC := $(shell pwd)

obj-m := als_ltr30x.o
als_ltr30x-objs := ltr30x.o

all:
	$(MAKE) -C $(KERNEL_SRC) M=$(SRC)
modules_install:
	$(MAKE) -C $(KERNEL_SRC) M=$(SRC) modules_install

clean:
	rm -f *.o *~ core .depend .*.cmd *.ko *.mod.c
	rm -f Module.markers Module.symvers modules.order
	rm -rf .tmp_versions Modules.symvers
