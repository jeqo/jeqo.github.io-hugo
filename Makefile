.PHONY: all
all:

.PHONY: platuml-png
platuml-png:
	for file in $(shell find $(CURDIR)/static/models -name "*.puml" -type f); do \
		echo $$file; \
		java -jar ${HOME}/bin/plantuml.jar $$file; \
	done;