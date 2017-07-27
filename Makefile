CASK = cask

SRCS = $(shell find .  -maxdepth 1 -name '*.el')
OBJECTS = $(SRCS:.el=.elc)
EMACS = $(shell sh -c 'type -P emacs')

.PHONY: test compile recompile clean install

.cask:
	$(CASK) install

$(OBJECTS): .cask
	$(CASK) build

compile: $(OBJECTS)

clean-elc:
	rm -f $(OBJECTS)

recompile: clean-elc compile

clean: clean-elc
	rm -rf .cask/

test: $(OBJECTS)
	cask exec ert-runner -L $(PWD)
