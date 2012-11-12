ShareBrew
==========
[![Build Status](https://secure.travis-ci.org/RyanHouston/share-brew.png?branch=master)](https://travis-ci.org/RyanHouston/share-brew)

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
- ```bundle install```
- ```cp config/database.yml.sample config/database.yml```
- Setup config/database.yml with your preferred configuration
- ```rake db:setup``` will create the database with the necessary tables and
  load seed data for the BJCP 2008 list of beer styles and a set of malts,
  hops, and yeasts to start out with.
- Start your rails application as normal
