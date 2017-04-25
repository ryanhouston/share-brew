# ShareBrew
[![Build Status](https://travis-ci.org/ryanhouston/share-brew.svg?branch=master)](https://travis-ci.org/ryanhouston/share-brew)

## Overview
ShareBrew aims to provide a space for beer homebrewers to store and share
their recipes. Brewers will have the ability to record details for each
batch they brew. This will allow for reflection on the brewing process
and changes to a recipe from batch to batch which will result in better
tasting beer and a deeper understanding of how changes in recipe and
brewing process effect the end product.

## Current Status
Work in progress.

## Installation / Setup

The seeds create an admin user `admin@sharebrew.com` with password `password`.

Using Docker Compose:
- `docker-compose up`
- `docker-compose run --rm web rake db:setup`
- Run specs with: `docker-compose run --rm web rake rspec` or just get a shell
  on a docker container, `docker-compose run --rm web bash` and run `bin/rspec`
  and other commands as you wish.

Without Docker Compose:
- Assumes you're running postgresql locally. Modify `config/database.yml` as
  required.
- `bundle install`
- `bin/rake db:setup` will create the database with the necessary tables and
  load seed data for the BJCP 2008 list of beer styles and a set of malts,
  hops, and yeasts to start out with.
- Start your rails application as normal: `bin/rails server`
