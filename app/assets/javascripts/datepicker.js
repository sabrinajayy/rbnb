// documentation (info on setting formats etc)
// http://bootstrap-datepicker.readthedocs.io/en/latest/options.html
// timepicker docs:
// https://github.com/jonthornton/jquery-timepicker

function init_datepick() {
  $('.datepick').datepicker({
    // do not change the format below, required by rails form
    format: 'yyyy-mm-dd',
    startDate: '0d',
    endDate: '+365d',
    todayHighlight: 'true',
    autoclose: 'true'
  });
  $('#basicExample').timepicker({
    minTime: '5:00am',
    maxTime: '11:00pm'
  });
};
