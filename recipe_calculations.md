Recipe Calculations
===================

Calculating the Malt Bill
-------------------------
### Original Gravity of Recipe

    Original Gravity of recipe = (total recipe gravity / batch size in gallons / 1000) - 1

    total recipe gravity in GUs = sum(GUs per fermentable)

### Final Gravity of Recipe
This is the expected final gravity of the beer. Currently this is being calculated using the attenuation factor of the yeast used in the beer. If attenuation of the yeast was 75% we would see the following:

    Final Gravity of recipe = calculated starting gravity * 0.75

This is a naive calculation which does not account for the fermentability of each specific fermentable. For example, a recipe using a large amount of crystal malts is going to end up with a high final gravity than a recipe based purely on two-row base malt.


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

#### Tinseth formula
[A chart](http://www.howtobrew.com/section1/chapter5-5.html) exists for this.

From the online publication of [How to Brew](http://www.howtobrew.com/section1/chapter5-5.html):
> The degree of utilization is composed of a Gravity Factor and a Time Factor.
> The gravity factor accounts for reduced utilization due to higher wort
> gravities. The boil time factor accounts for the change in utilization due to
> boil time

    Utilization = f(G) x f(T)
    where
    f(G) = 1.65 x 0.000125^(Gb - 1)
    f(T) = [1 - e^(-0.04 x T)] / 4.15

Calculating Color
-----------------
The color of malts is talked about using degrees Lovibond (L) while beer color is talked about in degrees on the Standard Reference Model scale (SRM). The two scales are in fact the same.

### Malt Color Units (MCU)
MCUs are like the AAUs used in IBU calculation. It's a unit which provides the color added by a malt with regard to malt color and amount used.

    MCUs of malt = degrees L x weight in pounds

If you added 1 pound of Crystal 40 with a Lovibond rating of 40, that would be equal to 40 MCUs.

### Standard Reference Model (SRM) estimate for a beer
The traditional model states that SRM color of a beer can be calculated by dividing the total recipe MCU by the volume of the batch. This is only accurate for beers up to 15 SRM though.

    SRM = (MCU / recipe volume)

More accurate models for calculating SRM color of beer across a full spectrum of colors have been proposed:

    SRM = 0.3 x MCU + 4.7    (Mosher)
    SRM = 0.2 x MCU + 8.4    (Daniels)
    SRM = 1.49 x MCU^0.69    (Morey)

Morey's model seems most accurate as it does not impose a floor which no beer can be lighter than as Mosher and Daniels models do, 4.7 and 8.4 respectively are the lightest beers. It is known that beers do come in lighter than 4.7 SRM.

In How To Brew, Palmer goes into other factors that affect beer color and states thatthese other factors are significant enough that the actual color could be as much as 20% plus or minus the calculated value. He then suggests we can simplify Morey's equation a bit to deter trying to calculate color down to precision levels which are not accurate.

    SRM = 1.5 x MCU^0.7    (Palmer)

ShareBrew will use Palmer's method.

Calculating Alcohol by Volume (ABV)
-----------------------------------
Two formulas provided by the Brewers Friend website.

The standard formula has been around and is relatively accurate.

    ABV = (og - fg) * 131.25

Another formula was devised that provides greater accuracy for higher gravity worts.

   ABV = (76.08 * (og-fg) / (1.775-og)) * (fg / 0.794)

ShareBrew will use this second, more accurate formula.

### References
[BrewersFriend](http://www.brewersfriend.com/2011/06/16/alcohol-by-volume-calculator-updated/)

References
----------
Palmer, John. How To Brew. 2006. Brewers Publications
