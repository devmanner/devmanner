ERLC		= /swift/Erlang/otp/bin/erlc
EBIN		= ebin/
ESRC		= esrc/
BASE_DIR	= `pwd`
BEAMS		= $(EBIN)scan.beam

all: $(BEAMS)
$(EBIN)%.beam: $(ESRC)%.erl
	$(ERLC) -DBASE_DIR=\"$(BASE_DIR)\" -o $(EBIN) $<

clean:
	rm -f ebin/* *~ esrc/*~ bin/*~
