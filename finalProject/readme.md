# EECE5644 Final Project
The goal of this study is to use image processing techniques to extract the latent features of a collection of artworks from the MoMA with hopes to determine which characteristics of the work can be classified by latent features (e.g. Nationality, Medium, Time Period).

## Included Files
* Our [project code](EECE5644_ProjectCode.m) includes the MATLAB file which produced our results
* The [cleaned data](museum_modern_art_parsed.csv) is a CSV file with all data used for the project

## Instructions to use
1. Pull the project code and CSV file to your local machine.
2. Run the code using MATLAB (development done using R2019a)
3. In order to change nationalities, uncomment the two nationalities you wish to compare in lines 16-18 and replace the variables in line 19 accordingly. For example, to compare French and Japanese artworks:
```matlab
% idx1 = find(nat_grps == 1); %American
idx27 = find(nat_grps == 27); %French
idx42 = find(nat_grps == 42); %Japanese
idx = [idx27(1:end/2);idx42(1:end)];
num = length(idx);
```

## Contributors
* Tzu Chieh Hung
* Nabeel Hussain
* James Tyler
* Aydin Wells
