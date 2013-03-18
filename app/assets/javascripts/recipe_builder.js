(function(BREWERING) {

  var RecipeBuilder = function(){
    //
  };

  RecipeBuilder.prototype.init = function() {
    var self = this;

    // Recipe form tabs
    var active_recipe_tab = $("#recipe.tabbed-content ul").data("active-tab");
    $("#recipe.tabbed-content").tabs({ active: active_recipe_tab });

    // Initialize chosen plugin for beer style chooser
    $(".chzn-select").chosen();

    // Show or hide mash efficiency as necessary
    self.evaluate_mash_efficiency_relevancy($('#recipe_mash_type option:selected').val());

    $(document).on('change', '#hop_addition_hop_id', function(event) {
      $.ajax({
        url: '/hops/' + $(this).val(),
        dataType: 'json',
        success: function(data) {
          $('#hop_addition_alpha_acid').val(data.alpha_acid);
          $('#hop_addition_beta_acid').val(data.beta_acid);
        }
      });
    });

    $(document).on('change', '#recipe_beer_style_id', function(event) {
      $.ajax({
        url: '/beer_styles/' + $(this).val(),
        dataType: 'json',
        success: function(data) {
          jQuery.each(data, function(attribute, value) {
            $('.style-guide .' + attribute).text(value);
          });
        }
      });
    });

    $(document).on('change', '#recipe_mash_type', function(event) {
      self.evaluate_mash_efficiency_relevancy($(this).val());
    });
  };

  RecipeBuilder.prototype.evaluate_mash_efficiency_relevancy = function(mash_type) {
    if (mash_type == 'grain') {
      $('.field-group.mash-efficiency').show();
    } else {
      $('.field-group.mash-efficiency').hide();
    }
  };


  BREWERING.recipeBuilder = new RecipeBuilder();

  return BREWERING;
}(BREWERING || {}));

$(document).ready(function() {
  if ($("body.recipe_builder").length) {
    console.log("Initializing RecipeBuilder");
    BREWERING.recipeBuilder.init();
  }
});

