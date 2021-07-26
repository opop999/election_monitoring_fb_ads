[![Extraction of FB ads with Docker Image](https://github.com/opop999/election_monitoring_fb_ads/actions/workflows/docker.yml/badge.svg?branch=master)](https://github.com/opop999/election_monitoring_fb_ads/actions/workflows/docker.yml)

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

# This repository is part of a [umbrella project](https://github.com/opop999?tab=projects) of the [2021 pre-election monitoring](https://www.transparentnivolby.cz/snemovna2021/) by the Czech chapter of Transparency International.

## Facebook & Instagram paid political advertisement extraction and analysis

### We aim to create an automated workflow, which would inform analysts covering the political communication and financing of the Czech 2021 parliamentary elections. This would ideally include:

-Extraction of the raw tables with FB ads, regional and demographic data. To this end, we use the FB Ads API access through a Radlibrary wrapper. In the automatization part, we use GitHub Actions which run using a [Docker container](https://hub.docker.com/u/rocker) to provide better compatibility and robustness.

-Transformation of the data to merge the three separate raw tables on the Ad ID.

-Summary tables for each of the political FB pages.

-Dashboard visualizations, including summary key indicators and time-series, deployed using GitHub Pages.

-Using these datasets for further NLP textual analyses down the pipeline.

### Current status (26 July 2021):

-We have a script that extracts and transforms the FB and Instagram Ads from specified pages (see the list below ). Furthermore, we have a script that creates summary tables from the whole dataset and another script, which compiles the analytical dashboard with visualizations available at the GitHub Pages of this repository. Individual HTML plots are to be found in the data/html_plots folder.

-These scripts are operational within the GitHub Actions workflow inside a Docker container and run automatically once daily according to a cron trigger.

-Data on ads from some of the pages cannot be downloaded using the API. This is a problem for some pages, where we could not obtain their numeric ids (such as pages without any ads in their history). Furthermore, the European Parliament page (unlike the rest) returns a region table with all of the regions in the EU as columns, exceeding the bandwidth of the API. As a workaround, we included the profiles of Czech representation of the EU Parliament and EU Commission instead.

### List of 80+ monitored political subjects (in no particular order):

| **POLITICAL SUBJECT**           | **URL**                                                   | **NUMERIC ID**   | **WORKS?** |
|:--------------------------------|:----------------------------------------------------------|:-----------------|:-----------|
| ODS                             | <https://www.facebook.com/ods.cz/>                        | 30575632699      | TRUE       |
| Zelení                          | <https://www.facebook.com/stranazelenych/>                | 39371299263      | TRUE       |
| TOP 09                          | <https://www.facebook.com/top09cz/>                       | 90002267161      | TRUE       |
| Česká pirátská strana           | <https://www.facebook.com/ceska.piratska.strana/>         | 109323929038     | TRUE       |
| ODS                             | <https://www.facebook.com/Jana.Cernochova/>               | 112718776235     | TRUE       |
| KSCM                            | <https://www.facebook.com/konecna.k/>                     | 119624098506     | TRUE       |
| KDU-ČSL                         | <https://www.facebook.com/Belobradek>                     | 156945169098     | TRUE       |
| Evropský parlament              | <https://www.facebook.com/europeanparliament/>            | 178362315106     | FALSE      |
| KDU                             | <https://www.facebook.com/kducsl/>                        | 251656685576     | TRUE       |
| Starostové pro Liberecký kraj   | <https://www.facebook.com/starostoveprolibereckykraj/>    | 258989695009     | TRUE       |
| Starostové (STAN)               | <https://www.facebook.com/starostove/>                    | 370583064327     | TRUE       |
| ODS, TOP09, KDU-ČSL             | <https://www.facebook.com/spolu21/>                       | 100201752249169  | TRUE       |
| Generál ve výslužbě             | <https://www.facebook.com/generalpavel/>                  | 102389958091735  | TRUE       |
| Česká pirátská strana           | <https://www.facebook.com/olga.piratka.richterova>        | 102844685102730  | TRUE       |
| Přísaha                         | <https://www.facebook.com/robertslachtaofficial>          | 103430204491217  | TRUE       |
| KNHP                            | <https://www.facebook.com/khnp.cz/>                       | 106008800769282  | TRUE       |
| ANO2011                         | <https://www.facebook.com/adamvojtech2017/>               | 106891623334554  | TRUE       |
| České zájmy v EU                | <https://www.facebook.com/CeskeZajmyEU/>                  | 108726857444837  | TRUE       |
| ODA, ADS, SKP, DSZ, Zdraví, aj. | <https://www.facebook.com/alianceprobudoucnost/>          | 109787574497667  | TRUE       |
| Česká pirátská strana           | <https://www.facebook.com/vojtechpikal>                   | 110687557739540  | TRUE       |
| ČSSD                            | <https://www.facebook.com/cssdcz/>                        | 111041662264882  | TRUE       |
| Zelení                          | <https://www.facebook.com/zofkovadavismagdalena>          | 115802229102602  | TRUE       |
| KSČM                            | <https://www.facebook.com/vojtech.filip.politik/>         | 119687288907752  | TRUE       |
| TOP 09                          | <https://www.facebook.com/kalousek.miroslav/>             | 132141523484024  | TRUE       |
| ODS                             | <https://www.facebook.com/ZbynekStanjura/>                | 134443820058669  | TRUE       |
| SPD                             | <https://www.facebook.com/tomio.cz/>                      | 179497582061065  | TRUE       |
| ANO 2011                        | <https://www.facebook.com/IngOndrejProkop/>               | 197010357446014  | TRUE       |
| ANO 2011                        | <https://www.facebook.com/anobudelip>                     | 211401918930049  | TRUE       |
| ANO 2011                        | <https://www.facebook.com/AndrejBabis/>                   | 214827221987263  | TRUE       |
| ANO 2011                        | <https://www.facebook.com/charanzova/>                    | 219333261570307  | TRUE       |
| KDU                             | <https://www.facebook.com/tomaszdechovsky/>               | 275042429350706  | TRUE       |
| Trikolóra                       | <https://www.facebook.com/vaclavklausml/>                 | 277957209202178  | TRUE       |
| KSČM                            | <https://www.facebook.com/komunistickastranacechamoravy/> | 298789466930469  | TRUE       |
| ODS                             | <https://www.facebook.com/a.vondra/>                      | 317802208282505  | TRUE       |
| Starostové pro Liberecký kraj   | <https://www.facebook.com/hejtmanmartinputa/>             | 326507470746765  | TRUE       |
| Česká pirátská strana           | <https://www.facebook.com/peksamikulas>                   | 356448681873897  | TRUE       |
| KDU                             | <https://www.facebook.com/JureckaMarian/>                 | 356451014434612  | TRUE       |
| ANO 2011                        | <https://www.facebook.com/SchillerovaAlena>               | 384187235387895  | TRUE       |
| MMR, EU                         | <https://www.facebook.com/kdefondyeupomahaji/>            | 470593056405865  | TRUE       |
| ODS                             | <https://www.facebook.com/petr.fiala1964/>                | 487445514669670  | TRUE       |
| Milion chvilek pro demokracii   | <https://www.facebook.com/milionchvilek/>                 | 728495140691300  | TRUE       |
| Trikolóra                       | <https://www.facebook.com/volimtrikoloru/>                | 739115596482745  | TRUE       |
| SPD                             | <https://www.facebook.com/hnutispd/>                      | 937443906286455  | TRUE       |
| Sev.en Energy                   | <https://www.facebook.com/skupinaSev.enEnergy/>           | 992555574111774  | TRUE       |
| Česká pirátská strana           | <https://www.facebook.com/PiratKolaja>                    | 995938427265360  | TRUE       |
| STAN                            | <https://www.facebook.com/farskyjansemily/>               | 1401321553476900 | TRUE       |
| TOP 09                          | <https://www.facebook.com/Marketa.AdamovaTOP09/>          | 1433946376688930 | TRUE       |
| Starostové (STAN)               | <https://www.facebook.com/vitrakusancz/>                  | 1477535869227480 | TRUE       |
| ANO 2011                        | <https://www.facebook.com/KlaraDostalovaMMR>              | 1736314393286600 | TRUE       |
| ANO 2011                        | <https://www.facebook.com/karelhavlicek1ekonom>           | UNKNOWN_ID       | FALSE      |
| ČSSD                            | <https://www.facebook.com/hamacekjan/>                    | UNKNOWN_ID       | FALSE      |
| SPD                             | <https://www.facebook.com/foldynajaroslavofficial/>       | UNKNOWN_ID       | FALSE      |
| Evropská Komise v ČR            | <https://www.facebook.com/EvropskaKomise.cz/>             | 397919187215     | TRUE       |
| Kancelář Evropského parlamentu  | <https://www.facebook.com/evropskyparlament/>             | 278212515809     | TRUE       |
| ODS                             | <https://www.facebook.com/KubaODS/>                       | 114474108677288  | TRUE       |
| Česká pirátská strana           | <https://www.facebook.com/pirat.lipavsky>                 | 108697510778834  | TRUE       |
| SPD 													  | <https://www.facebook.com/MUdrIDavid>                     | 466459903794526  | TRUE       |
| SPD                             | <https://www.facebook.com/Hynek-Blaško-europoslanec-110278350358403> | 110278350358403  | TRUE       |
| ODS                             | <https://www.facebook.com/jan.skopecek.3/>                | 1434319750128022 | TRUE       |
| KDU-ČSL												  | <https://www.facebook.com/pgolasowska/>                   | 1795946254027412 | TRUE       |
| Svobodní											  | <https://www.facebook.com/valentaivo/>                    | 1414644678821208 | TRUE       |
| STAN  													| <https://www.facebook.com/martin.baxa/>           			  | 146713862010620  | TRUE       |
| SPOLU 												  | <https://www.facebook.com/pavelsvobodapardubice/>         | 104264008348176  | TRUE       |
| SPOLU	                          | <https://www.facebook.com/havelztopky/>            			  | 351488672592066  | TRUE       |
| STAN													  | <https://www.facebook.com/tomasgolansenator/>             | 1917661888252695 | TRUE       |
| SPOLU													  | <https://www.facebook.com/Ing.StanislavBlaha/>            | 495496033796328  | TRUE       |
| KDU-ČSL												  | <https://www.facebook.com/HejtmanJMK/>            				| 1681478228766601 | TRUE       |
| Česká pirátská strana 				  | <https://www.facebook.com/PiratKaderavek/>                | 104517784280261	 | TRUE       |
| ODS														  | <https://www.facebook.com/martin.kupka1/>         	  	  | 553773474671244  | TRUE       |
| ČSSD													  | <https://www.facebook.com/Povsik/>                        | 301147597357008  | TRUE       |
| ČSSD													  | <https://www.facebook.com/kajnarpetr/>                    | 107747200956355  | TRUE       |
| KDU-ČSL												  | <https://www.facebook.com/frantisek.talir/>               | 2108659169383946 | TRUE       |
| NEZÁVISLÍ 										  | <https://www.facebook.com/StodulkaPavel/>                 | 471227586234132  | TRUE       |
| ANO 2011											  | <https://www.facebook.com/hejtmanradimholis/>             | 100913275009934  | TRUE       |
| SPOLU PRO KRAJ								  | <https://www.facebook.com/jiristepan.khk/>                | 424122987643945  | TRUE       |
| Česká pirátská strana 				  | <https://www.facebook.com/PiratDanielKus/>                | 101894271393926  | TRUE       |
| ČSSD	                				  | <https://www.facebook.com/Ivo.Gruner1969/>                | 176459739425212  | TRUE       |
| Koalice pro Pardubický kraj		  | <https://www.facebook.com/romanlinek/>                    | 129667385500897  | TRUE       |
| ČSSD                  				  | <https://www.facebook.com/MichalSmarda.NMNM/>             | 1104866262972886 | TRUE       |
| Václav Salač / FAČR    				  | <https://www.facebook.com/vaclavsalacfotbal/>             | 100102138818077  | TRUE       |





