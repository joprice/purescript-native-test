# TODO: test on larger program
run-no-gc: 
	GOGC=off ./Main

update-deps:
	go list -u -m all

symbols:
	go tool nm -size ./Main | c++filt > symbols.txt
