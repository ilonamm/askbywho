$('#email_name_brands').select2({
  tags: true,
  width: '100%',
  ajax: {
    url: '/api/v1/brands',
    dataType: 'json',
    delay: 1000,
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
  placeholder: $placeholder
});
