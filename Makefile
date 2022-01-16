
all:	build/exec/idris2-template
	build/exec/idris2-template

build/exec/idris2-template:	src/Main.idr
	idris2 --build --find-ipkg
