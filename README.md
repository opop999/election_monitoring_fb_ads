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

|                                       |                                                           |                     |                         |
|---------------------------------------|-----------------------------------------------------------|---------------------|-------------------------|
| **Political Subject**                 | **Url**                                                   | **Numeric page id** | **Can we extract?**     |
| ODS                                   | <https://www.facebook.com/ods.cz/>                        | 30575632699         | TRUE                    |
| Zelení                                | <https://www.facebook.com/stranazelenych/>                | 39371299263         | TRUE                    |
| TOP 09                                | <https://www.facebook.com/top09cz/>                       | 90002267161         | TRUE                    |
| Česká pirátská strana                 | <https://www.facebook.com/ceska.piratska.strana/>         | 109323929038        | TRUE                    |
| ODS                                   | <https://www.facebook.com/Jana.Cernochova/>               | 112718776235        | TRUE                    |
| KSCM                                  | <https://www.facebook.com/konecna.k/>                     | 119624098506        | TRUE                    |
| KDU-ČSL                               | <https://www.facebook.com/Belobradek>                     | 156945169098        | TRUE                    |
| Evropský parlament - nekandiduje      | <https://www.facebook.com/europeanparliament/>            | 178362315106        | FALSE                   |
| KDU                                   | <https://www.facebook.com/kducsl/>                        | 251656685576        | TRUE                    |
| Starostové pro Liberecký kraj         | <https://www.facebook.com/starostoveprolibereckykraj/>    | 258989695009        | TRUE                    |
| Starostové (STAN)                     | <https://www.facebook.com/starostove/>                    | 370583064327        | TRUE                    |
| ODS, TOP09, KDU-ČSL                   | <https://www.facebook.com/spolu21/>                       | 100201752249169     | TRUE                    |
| Generál ve výslužbě - nekandiduje     | <https://www.facebook.com/generalpavel/>                  | 102389958091735     | TRUE                    |
| Česká pirátská strana                 | <https://www.facebook.com/olga.piratka.richterova>        | 102844685102730     | TRUE                    |
| Přísaha                               | <https://www.facebook.com/robertslachtaofficial>          | 103430204491217     | TRUE                    |
| KNHP -                                
 nekandiduje                            | <https://www.facebook.com/khnp.cz/>                       | 106008800769282     | TRUE                    |
| ANO2011                               | <https://www.facebook.com/adamvojtech2017/>               | 106891623334554     | TRUE                    |
| České                                 
 zájmy v EU - nekandiduje               | <https://www.facebook.com/CeskeZajmyEU/>                  | 108726857444837     | TRUE                    |
| ODA, ADS, SKP, DSZ, Zdraví,           
 sport prosperita, Starostové pro kraj  | <https://www.facebook.com/alianceprobudoucnost/>          | 109787574497667     | TRUE                    |
| Česká                                 
 pirátská strana                        | <https://www.facebook.com/vojtechpikal>                   | 110687557739540     | TRUE                    |
| ČSSD                                  | <https://www.facebook.com/cssdcz/>                        | 111041662264882     | TRUE                    |
| Zelení                                | <https://www.facebook.com/zofkovadavismagdalena>          | 115802229102602     | TRUE                    |
| KSČM - Komunistická strana Čech       
 a Moravy                               | <https://www.facebook.com/vojtech.filip.politik/>         | 119687288907752     | TRUE                    |
| TOP 09                                | <https://www.facebook.com/kalousek.miroslav/>             | 132141523484024     | TRUE                    |
| ODS                                   | <https://www.facebook.com/ZbynekStanjura/>                | 134443820058669     | TRUE                    |
| SPD                                   | <https://www.facebook.com/tomio.cz/>                      | 179497582061065     | TRUE                    |
| ANO 2011                              | <https://www.facebook.com/IngOndrejProkop/>               | 197010357446014     | TRUE                    |
| ANO                                   
 2011                                   | <https://www.facebook.com/anobudelip>                     | 211401918930049     | TRUE                    |
| ANO 2011                              | <https://www.facebook.com/AndrejBabis/>                   | 214827221987263     | TRUE                    |
| ANO2011                               | <https://www.facebook.com/charanzova/>                    | 219333261570307     | TRUE                    |
| KDU                                   | <https://www.facebook.com/tomaszdechovsky/>               | 275042429350706     | TRUE                    |
| Trikolóra                             | <https://www.facebook.com/vaclavklausml/>                 | 277957209202178     | TRUE                    |
| KSČM - Komunistická strana Čech       
 a Moravy                               | <https://www.facebook.com/komunistickastranacechamoravy/> | 298789466930469     | TRUE                    |
| ODS                                   | <https://www.facebook.com/a.vondra/>                      | 317802208282505     | TRUE                    |
| Starostové pro Liberecký kraj         | <https://www.facebook.com/hejtmanmartinputa/>             | 326507470746765     | TRUE                    |
| Česká                                 
 pirátská strana                        | <https://www.facebook.com/peksamikulas>                   | 356448681873897     | TRUE                    |
| KDU                                   | <https://www.facebook.com/JureckaMarian/>                 | 356451014434612     | TRUE                    |
| ANO                                   
 2011                                   | <https://www.facebook.com/SchillerovaAlena>               | 384187235387895     | TRUE                    |
| MMR, EU - nekandiduje                 | <https://www.facebook.com/kdefondyeupomahaji/>            | 470593056405865     | TRUE                    |
| ODS                                   | <https://www.facebook.com/petr.fiala1964/>                | 487445514669670     | TRUE                    |
| Milion chvilek pro demokracii -       
 nekandiduje                            | <https://www.facebook.com/milionchvilek/>                 | 728495140691300     | TRUE                    |
| Trikolóra                             | <https://www.facebook.com/volimtrikoloru/>                | 739115596482745     | TRUE                    |
| SPD                                   | <https://www.facebook.com/hnutispd/>                      | 937443906286455     | TRUE                    |
| Sev.en                                
 Energy - nekandiduje                   | <https://www.facebook.com/skupinaSev.enEnergy/>           | 992555574111774     | TRUE                    |
| Česká pirátská strana                 | <https://www.facebook.com/PiratKolaja>                    | 995938427265360     | TRUE                    |
| STAN                                  | <https://www.facebook.com/farskyjansemily/>               | 1401321553476900    | TRUE                    |
| TOP 09                                | <https://www.facebook.com/Marketa.AdamovaTOP09/>          | 1433946376688930    | TRUE                    |
| Starostové                            
 (STAN)                                 | <https://www.facebook.com/vitrakusancz/>                  | 1477535869227480    | TRUE                    |
| ANO 2011                              | <https://www.facebook.com/KlaraDostalovaMMR>              | 1736314393286600    | TRUE                    |
| ANO                                   
 2011                                   | <https://www.facebook.com/karelhavlicek1ekonom>           | NO_ADS_UNKNOWN_ID   | FALSE                   |
| ČSSD                                  | <https://www.facebook.com/hamacekjan/>                    | NO_ADS_UNKNOWN_ID   | FALSE                   |
| SPD                                   | <https://www.facebook.com/foldynajaroslavofficial/>       | NO_ADS_UNKNOWN_ID   | FALSE                   |
| Evropská Komise v ČR                  | <https://www.facebook.com/EvropskaKomise.cz/>             | 397919187215        | TRUE                    |
| Kancelář                              
 Evropského parlamentu                  | <https://www.facebook.com/evropskyparlament/>             | 278212515809        | TRUE                    |
