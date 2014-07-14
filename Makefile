all:
	ghc --make -threaded site.hs
	./site build
	./site watch

clean:
	./site clean
	rm -rf site
	rm -rf site.hi