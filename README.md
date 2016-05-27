# Music Genre Detection in Scilab

This is based on this article : http://ismir2001.ismir.net/pdf/tzanetakis.pdf

## Introduction

This program is used to determine the genre of a musical piece. It uses 5 features based
on the FFT that are described in the article (link above). I have not implemented the 
wavelet-based features that are also described.

At the moment, the program can only determine whether a piece is electronic music or 
classical music.

## Method and content

The program analysis.sce computes the 5 features for a given music piece.
"logit.R" takes data points and calculates a logit regression.
The program predict.sce uses the logit to tell whether the piece is electronic music or
classical music.

## Results

I trained the model with 4 points and tested it on 4 other points and it works (see analysis.sce).

## TODO

- Use a bigger training set 
- Use KNN instead of logit so we can handle more genres
- Port this to another language


