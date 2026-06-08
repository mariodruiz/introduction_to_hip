# ------------------------------

HIPCC         = hipcc
OFFLOAD_ARCH ?= gfx942,gfx1100,gfx1150,gfx1151,gfx1201
HIPFLAGS      = --offload-arch=$(OFFLOAD_ARCH)

# ------------------------------

matrix_addition: matrix_addition.o
	$(HIPCC) $(HIPFLAGS) matrix_addition.o -o matrix_addition

matrix_addition.o: matrix_addition.cpp
	$(HIPCC) $(HIPFLAGS) -c matrix_addition.cpp

.PHONY: clean

clean:
	rm -f matrix_addition *.o
