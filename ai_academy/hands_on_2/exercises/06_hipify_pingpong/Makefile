# ------------------------------

HIPCC    = hipcc
OFFLOAD_ARCH ?= gfx942,gfx1100,gfx1150,gfx1151,gfx1201
HIPFLAGS      = --offload-arch=$(OFFLOAD_ARCH)

# ------------------------------

pingpong: pingpong.o
	$(HIPCC) $(HIPFLAGS) pingpong.o -o pingpong

pingpong.o: pingpong.cpp
	$(HIPCC) $(HIPFLAGS) -c pingpong.cpp

.PHONY: clean

clean:
	rm -f pingpong *.o
