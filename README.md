# Developing Data Products - Assignment

## Coursera Data Science Specialization

### Background

This application explores the 2015 temperature data for the United States.

There are two datasets used as inputs to create the needed files for the Shiny Application. Both are from NOAA.GOV. 

- Dataset 1: Yearly weather data for 2015 - ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/by_year/

- Dataset 2: Observation station list - ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/ghcnd-stations.txt
 

### Usage

Upon launching the application, the default display is a summary Morris chart with maximum, minimum, and average temperature readings for the entire U.S. in Fahrenheit.

The user is able to select the temperature measurement type (fahrenheit, celsius).

When the user selects a state the Morris chart updates with summary data for the state as well as populating the Location selection box with all of the observation station locations in the selected state.

By selecting a location, the chart is updated with the observed temperatures for that observation station. Users are then able to explore temperature readings across the state locations or change states as desired.
 

### Data

The data from the two NOAA datasets are pre-processed, cleaned, and joined outside of the Shiny Application due to the excessive time required for processing.

The R code for the pre-processing can be found in "Weather Analysis US.Rmd" and will require around 28 hours to complete.

There are 3 output ".Rds" files that are created to be used as inputs to the Shiny App.

- Rds 1: "wd_2015_US.rds" - Used for individual observation station charts

- Rds 2: "state_summary_2015.rds" - Used for individual state charts

- Rds 3: "us_summary_2015.rds" - Used for U.S. summary chart


### Shiny Application Location

The Shiny Application can be found at: https://tterry231.shinyapps.io/USWeather2015/


### Slidify Location

The presentation can be found at: http://rpubs.com/tterry231/USTempData

