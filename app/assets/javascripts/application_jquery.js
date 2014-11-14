$(document).ready(function() {
    table = $('#example').DataTable( {
//        tableClass: "table",
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

        "language": {
            "emptyTable":     "В таблице отсутствуют данные",
            "info":           "Показаны с _START_ по _END_ из _TOTAL_ записей",
            "infoEmpty":      "Показаны 0 из 0 записей",
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

//Добавление поля описания, для "другого"
$(document).ready(function() {
    if ($('#requistion_type_requistion :selected').text()!='Другое')
        $('#info').hide()
    else
        $('#info').show()
    $('#requistion_type_requistion').change(function () {
        if ($('#requistion_type_requistion :selected').text()!='Другое')
            $('#info').hide()
        else
            $('#info').show()
    })
})

//Добавление поля описания, для "другого"
$(document).ready(function() {
    if ($('#requistion_type_requistion :selected').text()!='Аварийное обслуживание')
        $('#subtype').hide()
    else
        $('#subtype').show()
    $('#requistion_type_requistion').change(function () {
        if ($('#requistion_type_requistion :selected').text()!='Аварийное обслуживание')
            $('#subtype').hide()
        else
            $('#subtype').show()
    })
})



$(document).ready(function() {
    $("#company").change(function () {
//        alert($("#company :selected").text());
        $.ajax({url: "/update_contracts",
            type: 'GET',
            dataType: 'html',
            data: "company=" + $('#company :selected').text(),
//            beforeSend: function (xhr) {
//                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
//            },
            success: function (data, status) {
//                alert("Data: " + data + "\nStatus: " + status);
                console.log(data[0].description);
                $("#versionsDiv").html(data);
            }
        });
    });
});

$(document).ready(function() {
    $("#company").blur(function(){
        $("#version_id").change(function () {
//            alert($("#version_id :selected").val());
            $.ajax({url: "/update_date",
                type: 'GET',
                dataType: 'json',
                data: "contract=" + $('#version_id :selected').val(),
                success: function (data, status) {
//                  alert("Data: " + data.description + "\nStatus: " + status);
                    $('#contract').val(data.name_contract);
                    $('#period_contract').val(data.time);
                    $('#description').val(data.description);
                }
            });
        });
    });

});


$(document).ready(function(){
    $('.form-control[required]').blur(function() {
        if($.trim($(this).val()) == '') {
            $(this).parent().addClass('has-error')    
            $(this).after('<span class="error">Поле не должно быть пустым!</span>');
        }else{
            $(this).parent().removeClass('has-error') 
        }
    });
    $('.form-control').focus(function() {
        $(this)
            .removeClass('error')
            .next('span')
            .remove();
    });
});

var count = 1;
$(document).ready(function() {
    $('#addbtn').click (function(){
        var new_work = $("#worker_row").clone().attr('id', count);
        new_work.wrap ("<div class='row'></div>").parent().insertBefore('#submut');
        new_work.find("select").attr('name', "worker" + count.toString()).blur(function() {
                if($.trim($(this).val()) == '') {
                    $(this).parent().addClass('has-error')    
                    $(this).after('<span class="error">Поле не должно быть пустым!</span>');
                }else{
                    $(this).parent().removeClass('has-error') 
                }
                });
                $('.form-control').focus(function() {
                    $(this)
                        .removeClass('error')
                        .next('span')
                        .remove();
                });
        count++;
    })
});