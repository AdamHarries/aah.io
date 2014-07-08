all:
	ghc --make -threaded site.hs
	./site build
	./site watch

clean:
	rm -rf _cache
	rm -rf _site
	rm -rf site
	rm -rf site.hi