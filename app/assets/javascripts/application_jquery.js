$(document).ready(function() {
    if ($('#requistion_type_requistion :selected').text()!='Другое')
        $('#test').hide()
    else
        $('#test').show()
    $('#requistion_type_requistion').change(function () {
        if ($('#requistion_type_requistion :selected').text()!='Другое')
            $('#test').hide()
        else
            $('#test').show()
    })
})

$(document).ready(function(){
    $('.form-control').blur(function() {
        if($(this).val().length == 0) {
            $(this)
                .addClass('error')
                .after('<span class="error">Поле не должно быть пустым!</span>');
        }
    });
    $('.form-control').focus(function() {
        $(this)
            .removeClass('error')
            .next('span')
            .remove();
    });
});

$(document).ready(function() {
    $("#company").change(function () {
        alert("1");
        $.ajax({url: "/static_pages/ajaxPages",
            type: 'post',
            dataType: 'json',
            data: "company=" + $('#company :selected').text(),
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
            success: function (data, status) {
                alert("Data: " + data + "\nStatus: " + status);
                $('#contract').val(data.id);
                $('#period_contract').val(data.time);
            }
        });
    });
});