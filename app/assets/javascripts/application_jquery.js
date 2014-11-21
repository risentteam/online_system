$.datepicker.setDefaults({
	closeText: 'Закрыть',
	prevText: 'Предыдущий',
	nextText: 'Следующий',
	currentText: 'Сегодня',
	monthNames: ['Январь','Февраль','Март','Апрель','Май','Июнь',
		'Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
	monthNamesShort: ['Янв','Фев','Мар','Апр','Май','Июн',
		'Июл','Авг','Сен','Окт','Ноя','Дек'],
	dayNames: ['воскресенье','понедельник','вторник','среда','четверг','пятница','суббота'],
	dayNamesShort: ['вск','пнд','втр','срд','чтв','птн','сбт'],
	dayNamesMin: ['Вс','Пн','Вт','Ср','Чт','Пт','Сб'],
	dateFormat:'dd.mm.yy',
	firstDay: 1,
	isRTL: false
});


$(document).ready(function() {
	var table = $('#requistions').dataTable({
		tableClass: "table-bordered",
		"dom": '<"container"lCfrtip> <"container"T>',
		"colVis": {
			  "buttonText": "Показать/скрыть столбцы"
		},
		"createdRow": function ( row, data, index ) {
			if ( data[10]=="получено" ) {
				$('td', row).addClass('danger');
			};
			if ( data[10]=="сделано" ) {
				$('td', row).addClass('success');
			};
			if ( data[10]=="рабочие отправлены" ) {
				$('td', row).addClass('warning');
			};
			if ( data[10]=="рабочие прибыли" ) {
				$('td', row).addClass('warning');
			};
			if ( data[10]=="рабочие ушли" ) {
				$('td', row).addClass('warning');
			};
		},
//***********************
		"tableTools": {
			"sSwfPath": "http://cdn.datatables.net/tabletools/2.2.2/swf/copy_csv_xls_pdf.swf",
			"sRowSelect": "os",
			"aButtons": [
				{
					"sExtends": "copy",
					"sButtonText": "Скопировать",
					"bFooter": false,                   
				},
				{
					"sExtends": "xls",
					"sButtonText": "Экспорт в xls",
					"bFooter": false,                     
					"sCharSet" : "utf16le",
					"bSelectedOnly" : true, 
					"mColumns": "visible",
					"sFileName" : "Заявки.xls",
					"sFieldSeperator" : ';'  
				},
				{
					"sExtends": "pdf",
					"sPdfOrientation": "landscape",
					"bFooter": false, 
					"sFileName" : "Заявки.pdf",
					"sPdfMessage": "Your custom message would go here.",
					"sCharSet" : "utf8" 
				},
				{
					"sExtends": "print",
					"sButtonText": "Предварительный просмотр",
					"bFooter": false,
					"sInfo": "Нажмите esc для выхода"                     
				},
			]

		},

//***********************
		"language": {
			"emptyTable":     "В таблице отсутствуют данные",
			"info":           "Показаны с _START_ по _END_ из _TOTAL_ записей",
			"infoEmpty":      "Показаны 0 из 0 записей",
			"infoFiltered":   "(отфильтровано из всех _MAX_ записей)",
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
//***********************       
	} );
	table.columnFilter({
		aoColumns: [    
			{ type: "text" },
			{ type: "select" },
			{ type: "date-range" },
			{ type: "text"},
			{ type: "text"},
			{ type: "select" },
			{ type: "select" },
			{ type: "text"},
			{ type: "select" },
			{ type: "date-range" },
			{ type: "select" },
			{ type: "number-range" }                                    
		]
	});
});


//Чтение рейтина

//#########################################################################################
//Добавление поля описания, для "другого"
//#########################################################################################
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

//#########################################################################################
//Подцепление договоров из базы данных
//#########################################################################################

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

//#########################################################################################
//Выделение пустых полей
//#########################################################################################
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
//#########################################################################################
//Добавление рабочих на заявку
//#########################################################################################
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