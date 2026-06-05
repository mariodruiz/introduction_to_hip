# ------------------------------

HIPCC         = hipcc
OFFLOAD_ARCH ?= gfx942,gfx1100,gfx1150,gfx1151,gfx1201
HIPFLAGS      = --offload-arch=$(OFFLOAD_ARCH)

# ------------------------------

scale_and_shift: scale_and_shift.o
	$(HIPCC) $(HIPFLAGS) scale_and_shift.o -o scale_and_shift

scale_and_shift.o: scale_and_shift.cpp
	$(HIPCC) $(HIPFLAGS) -c scale_and_shift.cpp

.PHONY: clean

clean:
	rm -f scale_and_shift *.o
