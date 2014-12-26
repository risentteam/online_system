$.extend({
  getUrlVars: function(){
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
      hash = hashes[i].split('=');
      vars.push(hash[0]);
      vars[hash[0]] = hash[1];
    }
    return vars;
  },
  getUrlVar: function(name){
    return $.getUrlVars()[name];
  },
});

$.datepicker.regional[""] = {
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
};

$.datepicker.setDefaults($.datepicker.regional['']);

var languageRU= {
			"emptyTable":     "В таблице отсутствуют данные",
			"info":           "Показаны с _START_ по _END_ из _TOTAL_ записей",
			"infoEmpty":      "Показаны 0 из 0 записей",
			"infoFiltered":   "(отфильтровано из всех _MAX_ записей)",
			"infoPostFix":    "",
			"thousands":      ",",
			"lengthMenu":     "Выводить по: _MENU_",
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
		};

var exportTools = {
			"sSwfPath": "http://cdn.datatables.net/tabletools/2.2.2/swf/copy_csv_xls_pdf.swf",
			"sRowSelect": "os",
			"aButtons": [
				// {
				// 	"sExtends": "copy",
				// 	"sButtonText": "Скопировать",
				// 	"bFooter": false,                   
				// },
				{
					"sExtends": "xls",
					"sButtonText": "Экспорт",
					"bFooter": false,                     
					"sCharSet" : "utf16le",
					"bSelectedOnly" : true, 
					"mColumns": "visible",
					"sFileName" : "Заявки.xls",
					"sFieldSeperator" : ';',  
					"oSelectorOpts": {
						page: 'current'
					}
				}
			]
		};



// var domValue = 		"<'row'<'col-xs-6'lC><'col-xs-6'f>r>" +
// 		"<'row'<'col-xs-12't>>" +
// 		"<'row'<'col-xs-4'i><'col-xs-3'T><'col-xs-5'p>>";

//новый ДОМ: бетта версия

var domValue =
		"<'row'<'col-xs-8'><'col-xs-4'r>><'row'<'col-xs-4 archiver'TC><'col-xs-1 '><'col-xs-5'><'col-xs-1'>><'row'<'col-xs-1'f><'col-xs-10'><'col-xs-1'l>>" +
		//"<'row'<'col-xs-1'lfT><'col-xs-3'><'col-xs-5'>prC>" +
		"<'row'<'col-xs-1'><'col-xs-10't<br>p><'col-xs-1'>>" +
		"<'row'<'col-xs-4'i><'col-xs-6'><'col-xs-1'><'col-xs-1'>>";


$(document).ready(function() {
	var table = $('#requistions').dataTable({
		
		tableClass: "table-bordered",
//новая часть часть отвечяющая за сохранение настроек таблицы
		stateSave: true,
		//"dom": '<"container"lCfrtip> <"container"T>',
		dom: domValue,
		"colVis": {
			  "buttonText": "Показать/скрыть столбцы"
		},
		"createdRow": function ( row, data, index ) {
			if ( data[11]=="новая" ) {
				$('td', row).addClass('danger');
			};
			if ( data[11]=="завершено" ) {
				$('td', row).addClass('success');
			};
			if ( data[11]=="отменена" ) {
				$('td', row).addClass('info');
			};
			if ( data[11]=="принята в работу" ) {
				$('td', row).addClass('warning');
			};
			if ( data[11]=="выполняется" ) {
				$('td', row).addClass('warning');
			};
			if ( data[11]=="исполнена" ) {
				$('td', row).addClass('warning');
			};

		},
//***********************
		"tableTools": exportTools,
//***********************
		"language": languageRU
//***********************       
	});
	table.columnFilter({
		aoColumns: [    
			{ type: "text"},
			{ type: "text" },
			{ type: "text" },
			{ type: "date-range" },
			{ type: "text"},
			{ type: "text"},
			{ type: "select" },
			{ type: "select" },
			{ type: "text"},
			{ type: "select" },
			{ type: "date-range" },
			{ type: "select" },
			{ type: "text" },
			{ type: "date-range" },
			{ type: "number-range" },
			{ type: "null" }                                   
		]
	});    
	var archiver = $("#archive").appendTo('.archiver');
});

$(document).ready(function(){
	var pos = $.getUrlVars()['position'];
	var value = $.getUrlVars()['value'];
	if (pos == '11')
	{
		$("select[rel="+pos+"]").find("option:contains('завершено')").attr("selected", "selected");
		$("select[rel="+pos+"]").trigger('change');
	}
	else
	{
	    value = ($("#for_filter").val());
	    $("input[rel="+pos+"]").val(value);
	    e = $.Event('keyup');
		for (var j in value)
		{
		    e.which = value.charCodeAt(j);
		    $("input[rel="+pos+"]").trigger(e);
		}
	}	
})

//#########################################################################################
//Таблица заявок у рабочего
//#########################################################################################
$(document).ready(function(){
	 var table = $('#requistion_for_workers').dataTable({
			tableClass: "table-bordered",
			"bLengthChange": false,
			"bPaginate": false,
			"bInfo": false,
			dom: domValue,
			"createdRow": function ( row, data, index ) {
				if ( data[4]=="назначена" ) {
					$('td', row).addClass('danger');
				};
				if ( data[4]=="завершено" ) {
					$('td', row).addClass('success');
				};
				if ( data[4]=="отменена" ) {
					$('td', row).addClass('info');
				};
				if ( data[4]=="принята в работу" ) {
					$('td', row).addClass('warning');
				};
				if ( data[4]=="выполняется" ) {
					$('td', row).addClass('warning');
				};
				if ( data[4]=="исполнена" ) {
					$('td', row).addClass('warning');
				
				};
			},
			"language": languageRU
	 });
	 table.columnFilter({
		aoColumns: [    
			{ type: "null" },
			{ type: "null" },
			{ type: "null" },
			{ type: "null" },			
			{ type: "select"},
			{ type: "null"},
			{ type: "null" }
		]
	});
});


//#########################################################################################
//Таблица заявок у клиента
//#########################################################################################
$(document).ready(function(){
	 var table = $('#requistion_for_clients').dataTable({
			tableClass: "table-bordered",
//			"bLengthChange": false,
//			"bPaginate": false,
			"bInfo": false,
//			dom : domValue,
			"createdRow": function ( row, data, index ) {
				if ( data[5]=="новая" ) {
					$('td', row).addClass('danger');
				};
				if ( data[5]=="завершено" ) {
					$('td', row).addClass('success');
				};
				if ( data[5]=="отменена" ) {
					$('td', row).addClass('info');
				};
				if ( data[5]=="принята в работу" ) {
					$('td', row).addClass('warning');
				};
				if ( data[5]=="выполняется" ) {
					$('td', row).addClass('warning');
				};
				if ( data[5]=="исполнена" ) {
					$('td', row).addClass('warning');
				};

			},

			"language": languageRU
	 });
	 table.columnFilter({
		aoColumns: [    
			{ type: "null" },
			{ type: "null" },
			{ type: "null" },
					
			{ type: "null"},
			{ type: "null" },
			{ type: "select"}	
		]
	});
});


//#########################################################################################
//Таблица контрактов
//#########################################################################################
$(document).ready(function(){
	 $('#contracts').dataTable({
			tableClass: "table-bordered",  
			stateSave: true,
			dom: domValue,
			"colVis": {
			  "buttonText": "Показать/скрыть столбцы"
			}, 
			"tableTools": exportTools, 		
			"language": languageRU	
	 });
});

//#########################################################################################
//Таблица контрактов у клиента
//#########################################################################################
$(document).ready(function(){
	 $('#contracts_clinet').dataTable({
			tableClass: "table-bordered",  
			stateSave: true,
			"language": languageRU	
	 });
});


//#########################################################################################
//Таблица объектов
//#########################################################################################
$(document).ready(function(){
	var table = $('#buildings').DataTable({
		tableClass: "table-bordered", 
		dom: domValue,
		"colVis": {
			  "buttonText": "Показать/скрыть столбцы"
		},
			stateSave: true,   		
			"tableTools": exportTools,
			"language": languageRU
	 });
});


//#########################################################################################
//Таблица рабочих
//#########################################################################################
$(document).ready(function(){
	var table = $('#tablework').DataTable({
		tableClass: "table-bordered", 
			"bInfo": false,
			"colVis": {
			  "buttonText": "Показать/скрыть столбцы"
		},
		dom: domValue,
		
			"tableTools": exportTools,
			"language": languageRU
	 });
});




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
//Всплывающее окно изменений во времени
//#########################################################################################
function reply_click(clicked_id)
{
    $('#testing').val(clicked_id)
			$.ajax({url: "/view_change_time",
				type: 'GET',
				dataType: 'json',
				data: "id=" + clicked_id,
				success: function (data, status) {
					$('#show_time_change_created').val(data.created);
					$('#show_time_change_assigned').val(data.assigned);
					$('#show_time_change_adopted').val(data.adopted);
					$('#show_time_change_running').val(data.running);
					$('#show_time_change_done').val(data.done);
					$('#show_time_change_comleted').val(data.completed);
					$('#show_time_change_deadline').val(data.deadline);
				}
			});
}

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
		new_work.wrap ("<div class='row'></div>").parent().insertBefore('#addbtn');
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

//#########################################################################################
//Добавление зданий к контракту
//#########################################################################################
var count = 1;
$(document).ready(function() {
	$('#addbtn').click (function(){
		var new_work = $("#building_group").clone().attr('id', count);
		new_work.wrap ("<div class='row'></div>").parent().insertBefore('#rowaddbtn');
		new_work.find("select").attr('name', "building" + count.toString()).blur(function() {
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

//#########################################################################################
//Отображение календаря
//#########################################################################################

$(document).ready(function() {
	$('button.calendarButton').click (function() {
		var id_of_btn = $(this).attr('id');
		id_of_btn = id_of_btn.split('-')[1];
		var id_of_calendar = "calendar-".concat(id_of_btn);
		$('#'+id_of_calendar).toggle();
		$('#cal').toggle();
	})
});

$(document).ready(function(){
	$('button.mark').click(function() {
		$("#mark_id").val($(this).attr("name"));
	});
});


//#########################################################################################
//Иконки в кнопках таблицы
//#########################################################################################

$(document).ready(function() {

$('.DTTT_button_xls').prepend ('<span class="glyphicon glyphicon-download-alt"></span>');
	$('.ColVis_MasterButton').prepend ('<span class="glyphicon glyphicon-eye-open"></span>');

	});



jQuery(function($){
	$("#requistions_range_from_3").attr("placeholder", "C").each(function () {
		this.previousSibling.parentNode.removeChild(this.previousSibling);
	});
	$("#requistions_range_from_10").attr("placeholder", "C").each(function () {
		this.previousSibling.parentNode.removeChild(this.previousSibling);
	});
	$("#requistions_range_from_13").attr("placeholder", "C").each(function () {
		this.previousSibling.parentNode.removeChild(this.previousSibling);
	});
	$("#requistions_range_from_14").attr("placeholder", "C").each(function () {
		this.previousSibling.parentNode.removeChild(this.previousSibling);
	});

	$("#requistions_range_to_3").attr("placeholder", "По").each(function () {
		this.previousSibling.parentNode.removeChild(this.previousSibling);
	});
	$("#requistions_range_to_10").attr("placeholder", "По").each(function () {
		this.previousSibling.parentNode.removeChild(this.previousSibling);
	});
	$("#requistions_range_to_13").attr("placeholder", "По").each(function () {
		this.previousSibling.parentNode.removeChild(this.previousSibling);
	});
	$("#requistions_range_to_14").attr("placeholder", "По").each(function () {
		this.previousSibling.parentNode.removeChild(this.previousSibling);
	});

});





