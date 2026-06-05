# ------------------------------

HIPCC    = hipcc
OFFLOAD_ARCH ?= gfx942,gfx1100,gfx1150,gfx1151,gfx1201
HIPFLAGS      = --offload-arch=$(OFFLOAD_ARCH)

# ------------------------------

matrix_multiply: matrix_multiply.o
	$(HIPCC) $(HIPFLAGS) matrix_multiply.o -o matrix_multiply

matrix_multiply.o: matrix_multiply.cpp
	$(HIPCC) $(HIPFLAGS) -c matrix_multiply.cpp

.PHONY: clean

clean:
	rm -f matrix_multiply *.o
