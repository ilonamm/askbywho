$('#email_name_brands').select2({
  tags: true,
  width: '100%',
  ajax: {
    url: '/api/v1/brands',
    dataType: 'json',
    data: function(params) {
      return {
        q: params.term,
        page: params.page,
        sort: 'name',
        order: 'asc'
      };
    },
    processResults: function(data, params) {
      params.page = params.page || 1;
      console.log(data.brands);
      return {
        results: data.brands,
        pagination: {
          more: params.page * 10 < data.total_count
        }
      };
    },
    cache: true
  },
  templateSelection: function(resultado) {
    return resultado.text;
  },
  escapeMarkup: function(m) {
    return m;
  },
  placeholder: TRANSLATIONS.placeholder
});

$('#js-nominate-switch-phase').click(function() {
  var phase1 = $('#js-nominate-phase-1');
  var phase2 = $('#js-nominate-phase-2');

  var checkedCount = $('input[type=checkbox]:checked').length;
  $('#js-nominate-brand-count').text(checkedCount);

  if (phase2.attr('hidden')) {
    phase2.removeAttr('hidden');
    phase1.attr('hidden', 'hidden');
  } else {
    phase1.removeAttr('hidden');
    phase2.attr('hidden', 'hidden');
  }
});
