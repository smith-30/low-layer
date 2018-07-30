.PHONY: test \
		clean

target=""

build:
	nasm -felf64 $(target).asm -o $(target).o && \
	ld -o $(target) $(target).o && \
	rm $(target).o

clean:
	rm *.o