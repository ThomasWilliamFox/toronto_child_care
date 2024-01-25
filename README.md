# Licensed Child Care Access Toronto's 25 Wards

## Overview

This repo includes all files needed to reproduce my paper "Licensed Child Care Access in Toronto ". This paper explores the child care facilities, income statistics, and child population in Toronto's 25 wards to assess the prevalence of and access to child care throughout the city of Toronto.

To use this folder, click the green "Code" button", then "Download ZIP". Move the downloaded folder to where you want to work on your own computer.

Run:

-   `scripts/01-download_data.R` to download the required data sets from Open Data Toronto.
-   `scripts/02-data_cleaning.R` to clean all relevant data for producing paper

Run/Render:

-   `outputs/toronto_child_care.R` to see how graphs/tables were created and render paper to PDF format

## File Structure

The repo is structured as:

-   `input/data` contains the data sources used in analysis including the raw data.
-   `outputs/data` contains the cleaned dataset that was constructed.
-   `outputs/paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
-   `scripts` contains the R scripts used to simulate, download and clean data.

**Statement on LLM usage: LLMs were not used in the writing of this paper.**
