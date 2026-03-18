# ------------------------------

HIPCC    = hipcc
OFFLOAD_ARCH ?= gfx90a,gfx942,gfx950
HIPFLAGS      = --offload-arch=$(OFFLOAD_ARCH)

# ------------------------------

vector_addition: vector_addition.o
	$(HIPCC) $(HIPFLAGS) vector_addition.o -o vector_addition

vector_addition.o: vector_addition.cpp
	$(HIPCC) $(HIPFLAGS) -c vector_addition.cpp

.PHONY: clean

clean:
	rm -f vector_addition *.o
