// documentation (info on setting formats etc)
// http://bootstrap-datepicker.readthedocs.io/en/latest/options.html

function init_datepick() {
  $('.datepick').datepicker({
    format: 'mm/dd/yyyy',
    startDate: '0d',
    endDate: '+365d',
    todayHighlight: 'true'
  });
};
