// documentation (info on setting formats etc)
// http://bootstrap-datepicker.readthedocs.io/en/latest/options.html
// timepicker docs:
// https://github.com/jonthornton/jquery-timepicker

function init_datepick() {
  $('.datepick').datepicker({
    format: 'mm/dd/yyyy',
    startDate: '0d',
    endDate: '+365d',
    todayHighlight: 'true'
  });
  $('#basicExample').timepicker({
    minTime: '5:00am',
    maxTime: '11:00pm'
  });
};
