# M1 Mac Docker container for bioconda

This is a BASH script and Dockerfile for creating and running a Docker container for bioconda on an M1 Macbook.

I read a bunch of posts/content online that assured that Rosetta on M1 can run Anaconda/Miniconda great (and it does), but I ran into trouble when trying to install certain packages from ([bioconda](https://bioconda.github.io)).  After reinstalling Anaconda a couple times, and even reinstalling MacOS with/without XCode commandline tools/Homebrew a couple times, I finally decided to try a Docker container... and it worked!  Hopefully this helps as a starting point to help others get an M1 set up to use computational biology tools from bioconda.

---------------------------------------------------------------------------------------------------

Shield: [![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]

This work is licensed under a
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg
