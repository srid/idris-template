
all:	idrisid 

idrisid:
	@echo "Launching idrisid"
	echo src/*.idr | entr -d sh -c 'make run'

run:	build/exec/idris2-template
	build/exec/idris2-template

build/exec/idris2-template:	src/Main.idr
	idris2 --build --find-ipkg
