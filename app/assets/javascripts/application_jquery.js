
$(document).ready(function() {
    table = $('#all_requistion').DataTable( {
        initComplete: function () {
            var api = this.api();
 
            api.columns().indexes().flatten().each( function ( i ) {
                var column = api.column( i );
                var select = $('<select><option value=""></option></select>')
                    .appendTo( $(column.footer()).empty() )
                    .on( 'change', function () {
                        var val = $(this).val();
 
                        column
                            .search( val ? '^'+val+'$' : '', true, false )
                            .draw();
                    } );
 
                column.data().unique().sort().each( function ( d, j ) {
                    select.append( '<option value="'+d+'">'+d+'</option>' )
                } );
            } );
        },

        "dom": '<"top"i>rt<"bottom"flp><"clear">', 
        "language": {
            "emptyTable":     "В таблице отсутствуют данные",
            "info":           "Показаны с _START_ по _END_ из _TOTAL_ записей",
            "infoEmpty":      "Ппоказаны 0 из 0 записей",
            "infoFiltered":   "(filtered from _MAX_ total entries)",
            "infoPostFix":    "",
            "thousands":      ",",
            "lengthMenu":     "Показывать по _MENU_ записей",
            "loadingRecords": "Подождите...",
            "processing":     "Обработка...",
            "search":         "Поиск:",
            "zeroRecords":    "Записей не найдено",
            "paginate": {
                "first":      "Первый",
                "last":       "Последний",
                "next":       "Следующий",
                "previous":   "Предыдущий"
            },
            "aria": {
                "sortAscending":  ": активировать для сортировки по возрастанию",
                "sortDescending": ": активировать для сортировки по убыванию"
            }
        }



        } );
});

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
    $('.form-control[required]').blur(function() {
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
        $.ajax({url: "/static_pages/ajaxPages",
            type: 'post',
            dataType: 'json',
            data: "company=" + $('#company :selected').text(),
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
            success: function (data, status) {
//                alert("Data: " + data + "\nStatus: " + status);
                $('#contract').val(data.id);
                $('#period_contract').val(data.time);
            }
        });
    });
});

var count = 1;
$(document).ready(function() {
    $('#addbtn').click (function(){
        $("#worker_row").clone().attr('id', count++).insertBefore("#addbtn");
    })
});