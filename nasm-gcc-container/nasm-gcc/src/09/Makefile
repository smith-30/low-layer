.PHONY: test \
		clean \
		cbuild

target=""

build:
	nasm -felf64 $(target).asm -o $(target).o && \
	ld -o $(target) $(target).o && \
	rm $(target).o

prepro:
	nasm -E $(target).asm

cbuild:
	gcc -o $(target) -ansi -pedantic-errors -Wall -Werror $(target).c

clean:
	rm *.o