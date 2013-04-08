(function ($) {
    $.fn.carrusel = function (opciones) {
        var pordefecto = {
            tiempo_delay: 5000,
            tiempo_transicion_in: 200,
            tiempo_transicion_out: 200,
            ciclico: true
        },
        opciones = $.extend({}, pordefecto, opciones),
            i = 0,
            total = this.size(),
            totus = this;

        function polvitomagico() {
            $(totus[i++]).fadeIn(opciones.tiempo_transicion_in).delay(opciones.tiempo_delay).
            fadeOut(opciones.tiempo_transicion_out, arguments.callee);
            if (opciones.ciclico && (i == total)) i = 0;
        }

        this.hide();
        polvitomagico();

        return this;
    }
})(jQuery);


$(function () {
    $.ajax({
        dataType: "jsonp",
        url: "https://api.twitter.com/1/statuses/user_timeline.json?screen_name=oigame",
        success: function (twits) {
            var html = '';
            for (i = 0; i < twits.length; i++) {
                html += '<li>' + twits[i].text + '</li>';
            }
            $('#twitter').html(html);
            $('#twitter>li').carrusel();
        }
    });
});
