require("jquery-ui")

$(function(){
    $('#start_date').datepicker({
        dateFormat: 'dd-mm-yy',
        minDate: 0,
        maxDate: '3m',
        onSelect: function(select) {
            $('#end_date').datepicker("option", "minDate", select);
            $('#end_date').attr('disabled', false);
        }
    })
    
    $('#end_date').datepicker({
        dateFormat: 'dd-mm-yy',
        minDate: 0,
        maxDate: '3m',
        onSelect: function(select) {
            $('#start_date').datepicker("option", "maxDate", select);
        }
    })
});


