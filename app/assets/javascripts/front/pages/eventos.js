$(document).ready(function() {
  var currentLangCode = 'es';
  function renderCalendar() {
      $('#calendar').fullCalendar({
        closeText: "Cerrar",
        prevText: "&#x3C;Ant",
        nextText: "Sig&#x3E;",
        currentText: "Hoy",
        monthNames: ["enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"],
        monthNamesShort: ["ene", "feb", "mar", "abr", "may", "jun", "jul", "ogo", "sep", "oct", "nov", "dic"],
        dayNames: ["domingo", "lunes", "martes", "miércoles", "jueves", "viernes", "sábado"],
        dayNamesShort: ["dom", "lun", "mar", "mié", "juv", "vie", "sáb"],
        dayNamesMin: ["D", "L", "M", "X", "J", "V", "S"],
        weekHeader: "Sm",
        dateFormat: "dd/mm/yy",
        firstDay: 1,
        isRTL: !1,
        showMonthAfterYear: !1,
        yearSuffix: "",
        titleFormat: {
          month: 'MMMM yyyy',
          week: "d[ MMMM][ yyyy]{ - d MMMM yyyy}",
          day: 'dddd d MMMM yyyy'
        },
        columnFormat: {
          month: 'ddd',
          week: 'ddd d',
          day: ''
        },
        axisFormat: 'H:mm',
        timeFormat: {
          '': 'H:mm',
          agenda: 'H:mm{ - H:mm}'
        },
        buttonText: {
            today: "Hoy",
            month: "Mes",
            week: "Semana",
            day: "Día",
            list: "Agenda"
        },
        allDayText: "Todo el día",
        header: {
          left: 'prev,next today',
          center: 'title',
          right: 'month,agendaWeek,agendaDay'
        },
        defaultDate: new Date(),
        buttonIcons: false, // show the prev/next text
        weekNumbers: true,
        editable: false,
        events: allEvents
      });
    }

    renderCalendar();
});