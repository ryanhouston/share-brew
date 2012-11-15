$(function() {
  $(document).on('change', '#hop_addition_hop_id', function(event) {
    $.get('/hops/' + $(this).val() + '.json', function(data) {
      $('#hop_addition_alpha_acid').val(data.alpha_acid);
      $('#hop_addition_beta_acid').val(data.beta_acid);
    });
  });
});

