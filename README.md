[![Extraction of FB ads with Docker Image](https://github.com/opop999/election_monitoring_fb_ads/actions/workflows/docker.yml/badge.svg?branch=master)](https://github.com/opop999/election_monitoring_fb_ads/actions/workflows/docker.yml)

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

# This repository is part of a [umbrella project](https://github.com/opop999?tab=projects) of the 2021 pre-election monitoring by the Czech chapter of Transparency International.

## Repository Focus: Facebook and Instagram political advertisement extraction and analysis

### Goal: To have an automated workflow, which would inform analysts covering the political communication and financing of the Czech 2021 parliamentary elections. This would ideally include:
-Extraction of the raw tables with FB ads, regional and demographic data. To this end, we use the FB Ads API access through a Radlibrary wrapper. In the automatization part, we use GitHub Actions which run using a [Docker container](https://hub.docker.com/u/rocker) to provide better compatibility and robustness.

-Transformation of the data to merge the three separate raw tables on the Ad ID.

-Summary tables for each of the political FB pages.

-Visualisation with dashboard for each of the pages and one that compares them all.

-Using these datasets for further NLP textual analyses down the pipeline.

### Current status (1 July 2021):
