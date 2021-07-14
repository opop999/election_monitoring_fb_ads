[![Extraction of FB ads with Docker Image](https://github.com/opop999/election_monitoring_fb_ads/actions/workflows/docker.yml/badge.svg?branch=master)](https://github.com/opop999/election_monitoring_fb_ads/actions/workflows/docker.yml)

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

# This repository is part of a [umbrella project](https://github.com/opop999?tab=projects) of the [2021 pre-election monitoring](https://www.transparentnivolby.cz/snemovna2021/) by the Czech chapter of Transparency International.

## Goal: Facebook & Instagram political advertisement extraction and analysis

### We aim to create an automated workflow, which would inform analysts covering the political communication and financing of the Czech 2021 parliamentary elections. This would ideally include:
-Extraction of the raw tables with FB ads, regional and demographic data. To this end, we use the FB Ads API access through a Radlibrary wrapper. In the automatization part, we use GitHub Actions which run using a [Docker container](https://hub.docker.com/u/rocker) to provide better compatibility and robustness.

-Transformation of the data to merge the three separate raw tables on the Ad ID.

-Summary tables for each of the political FB pages.

-Visualisation with dashboard for each of the pages and one that compares them all.

-Using these datasets for further NLP textual analyses down the pipeline.

### Current status (14 July 2021):
-We have a script that extracts and transforms the FB and Instagram Ads from specified pages. Furthermore, we have a script that creates summary tables from the whole dataset. 

-These scripts are operational within GitHub Actions workflow and run automatically once daily according to a cron trigger.
