# ------------------------------

HIPCC    = hipcc
OFFLOAD_ARCH ?= gfx942,gfx1100,gfx1150,gfx1151,gfx1201
HIPFLAGS      = --offload-arch=$(OFFLOAD_ARCH)

# ------------------------------

add_one: add_one.o
	$(HIPCC) $(HIPFLAGS) add_one.o -o add_one

add_one.o: add_one.cpp
	$(HIPCC) $(HIPFLAGS) -c add_one.cpp

.PHONY: clean

clean:
	rm -f add_one *.o
