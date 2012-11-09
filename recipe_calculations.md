Recipe Calculations
===================

Calculating the Malt Bill
-------------------------
### Original Gravity of Recipe

    Original Gravity of recipe = (total recipe gravity / batch size in gallons / 1000) - 1

    total recipe gravity in GUs = sum(GUs per fermentable)

### Gravity Units per Fermentable in Recipe
    GUs per fermentable = gravity per lb. X weight in lbs

This is the number of gravity units (GUs) for that particular fermentable.

Gravity per lb. = (extract potential X mash efficiency)

__extract potential__
:  provided by the maltster for each malt. Tables with average values for most popular malts exist for this in various places.

__mash efficiency__
:  calculated from results of previous brewing sessions on a particular brewing rig. An average to start with if there is no known efficiency for the brewhouse is 65%.

Calculating the Hops
--------------------
### Alpha Acid Units (AAUs)

    Weight (oz) x % Alpha Acids (whole number)
  e.g 1 oz of Cascade with 4.4% alpha acid = 4.4 AAUs

### International Bitterness Units (IBUs)

    IBU = AAU x U X 75 / Vrecipe

- Vrecipe = Recipe volume
- U = hop utilization

### Hop utilization

A function of time and gravity of wort. Describes the efficiency of the isomerization of the alpha acids as a function of time.

[A chart](http://www.howtobrew.com/section1/chapter5-5.html) exists for this.

References
----------
Palmer, Johnr. How To Brew
