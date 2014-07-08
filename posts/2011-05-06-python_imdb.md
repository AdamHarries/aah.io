---
title: IMDB Actor set intersection
---

#Python imdb actor intersection

A short (very) toy to find the intersection of actors between two films. Written in python, and available to download [here](imdb_intersect.py)

###Usage

To use, simply call:
	
	python imdb_intersect.py "Film one" "Film two" "Film three" ...

For any N films (N>=2)
For example:
	
	python imdb_intersect.py "Hot Fuzz" "Shaun of the dead" "Paul"

gives

	Simon Pegg
	Nick Frost

###Limitations

Unfortunately, due to the API I'm using this'll only calculate the intersection between the top ~10 actors in a film. If anyone's got any tips on using the official imdb api then that'd be great!

Uses the api at: [imdbapi](imdbapi.org)
