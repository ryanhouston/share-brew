ShareBrew
==========

Overview
---------
ShareBrew aims to provide a space for beer homebrewers to store and share
their recipes. Brewers will have the ability to record details for each
batch they brew. This will allow for reflection on the brewing process
and changes to a recipe from batch to batch which will result in better
tasting beer and a deeper understanding of how changes in recipe and
brewing process effect the end product.

Current Status
--------------
This project is a slowly moving target.

Installation / Setup
---------------------
Run 'cp config/database.yml.sample config/database.yml'
Edit config/database.yml with your mysql username and password
Run 'rake db:migrate'
Ruan 'script/server' or set up your server however you prefer.
