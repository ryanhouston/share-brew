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

```ruby
class TinsethHopUtilizationFormula
  def self.utilization( boil_gravity, boil_time )
    utilization_due_to_gravity(boil_gravity) * utilization_for_time(boil_time)
  end

  def self.utilization_due_to_gravity( boil_gravity )
    1.65 * 0.000125**(boil_gravity - 1)
  end

  def self.utilization_for_time( boil_time )
    (1 - Math.exp(-0.04 * boil_time)) / 4.15
  end
end
```

```ruby
class IBUCalculator
  def ibus_for_addtion(weight, alpha_acid, boil_time, boil_gravity, batch_size)
    AAUs_for_addition(weight, alpha_acid) *
      hop_utilization(boil_gravity, boil_time) * 75 / batch_size
  end

  def AAUs_for_addition(weight, alpha_acid)
    weight * alpha_acid
  end

  def hop_utilization( boil_gravity, boil_time )
    TinsethHopUtilizationFormula.utilization(boil_gravity, boil_time)
  end
end
```

References
----------
Palmer, John. How To Brew
