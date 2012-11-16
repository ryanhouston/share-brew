$(function() {
  // Initialize chosen plugin for beer style chooser
  $(".chzn-select").chosen();

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
});

