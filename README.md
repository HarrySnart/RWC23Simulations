# Simulating the Rugby World Cup 2023 Tournament using Probabalistic Sampling

View Interactive dashboard here: [bit.ly/sim-rwc23](bit.ly/sim-rwc23)

This project uses a combination of PYMC (for probabalistic modelling), Python (for discrete event simulation) and SAS Viya (for pre-processing, post-processing and data visaulization) in order to simulate probable fixture outcomes for the France 2023 Rugby World Cup. 

The workflow for the modelling and simulations can be summarised as:
![](workflow.png?raw=true)

## Estimating win-rate by team

The win-rate for teams is estimated using a hierarchical Bayesian model where the true win-rate is a Beta distribution Random Variable learned from historic win-rates. Data is 2022-23 for Tier 1 sides, and 2019-2023 for Tier 2 sides due to the sparsity of observations. Given that many sides have not played each other in recent years, simulation of fixture outcomes is done in a rudimentary way, taking samples from the posterior for win rate and comparing which side is more likely to win.

The Directed Acyclic Graph (DAG) for the PYMC model is:
![](dag.png?raw=true)

## Simulating results

The complete tournament is simulated 20,000 times using the probability model to randomly sample and assess fixture results. Whilst there is some shrinkage in the model, and an overestimation on performance for Tier 2 sides in some cases, over many simulations clear patters begin to emerge in the data.
![](sim_model.png?raw=true)

## Visualizing simulations

Once the simulation data is post-processed and reshaped, it is possible to visualize tournament pathways via sankey diagrams as well as visualize the likely winners of pools and knock-out stages. This is done using a SAS Visual Analytics dashboard.
![](dashboard.png?raw=true)

## How to use the Interactive Scenario Analysis App

The dashboard has been exported to a SAS Report Package. This can be ran locally and played with. 

This app is packaged as a zip file. To use it please start by unzipping it. This was tested using 7zip on Windows 10.

The simplest way to use this application is to run it with the live preview in Visual Studio Code using the free extension "Live Preview".

Alternatively, this is also easily achieved using Node.js. The steps are:
- Download Node.js
- Install http-server running the command `npm install http-server -g` in the command line interface
- Navigate into the openned zip directory `cd <path-to-dir>`
- Run the command `npx http-server`
- This will create a web server where you can access the report via http://127.0.0.1:8080

  
