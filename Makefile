build:
	for d in $$(find . -name Dockerfile -exec dirname {} \;); do \
	  cd $$d && \
	  doo b && \
	  cd ..; \
	done
