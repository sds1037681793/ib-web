/*!
 * jQuery ClassyCountdown
 * www.class.pm
 *
 * Written by Marius Stanciu - Sergiu <marius@class.pm>
 * Licensed under the MIT license www.class.pm/LICENSE-MIT
 * Version 1.0.0
 *
 */

(function($) {
    $.fn.ClassyCountdown = function(options, callback) {
        var element = $(this);
        var Value;
		var value = options.value;
        var isInited = false;
        var settings = {
            end: undefined,
            now: $.now(),
            labels: true,
            labelsOptions: {
                lang: {
                    seconds: '%'
                },
                style: 'font-size: 0.5em;'
            },
            style: {
                element: 'width:'+element.width()+'px;',
                labels: false,
                textResponsive: 0.5,
                seconds: {
                    gauge: {
                                    thickness: 0.18,
                                    bgColor: "rgba(0,118,228,0.3)",
                                    fgColor: "#0074E3",
                                    lineCap: 'round'
                    },
                    textCSS: 'font-size: 40px; color: #FFFFFF; letter-spacing: -0.14px;line-height: 48.48px;'
                }
            },
            onEndCallback: function() {
            }
        };
        
        settings = $.extend(true, settings, options);
        prepare();
        doTick();
        doResponsive();
        
        function prepare() {
        	var child = element.find('div');
			if(typeof(child.val())!='undefined'){
				doTick();
			}else{
		    element.append('<div class="ClassyCountdown-wrapper">' +
                    '<div class="ClassyCountdown-seconds">' +
                        '<input type="text" />' +
                        '<span class="ClassyCountdown-value"><div></div><span></span></span>' +
                    '</div>' +
                '</div>');
           
            element.find('.ClassyCountdown-seconds input').knob($.extend({
                width: '100%',
                displayInput: false,
                readOnly: true,
                max: 60
            }, settings.style.seconds.gauge));
            element.find('.ClassyCountdown-wrapper > div').attr("style", settings.style.element);
            element.find('.ClassyCountdown-seconds .ClassyCountdown-value').attr('style', settings.style.seconds.textCSS);
            element.find('.ClassyCountdown-value').each(function() {
                $(this).css('margin-top', Math.floor(0 - (parseInt($(this).height()) / 2)) + 'px');
            });
            if (settings.labels) {
                element.find(".ClassyCountdown-seconds .ClassyCountdown-value > span").html();
                element.find(".ClassyCountdown-value > span").attr("style", settings.labelsOptions.style);
            }
			}
        }
        
        function secondsToDHMS() {
			
            Value = Math.floor(value/100 * 60);
			
        }
		
	      function doTick() {
            secondsToDHMS();
            if (value <= 0) {
                Value = 0;
            }
            element.find('.ClassyCountdown-seconds input').val(Value).trigger('change');
            element.find('.ClassyCountdown-seconds .ClassyCountdown-value > div').html(value+"%");
			isInited = true;
        }
        
        function doResponsive() {
            element.find('.ClassyCountdown-wrapper > div').each(function() {
                $(this).css('height', $(this).width() + 'px');
            });
            if (settings.style.textResponsive) {
                element.find('.ClassyCountdown-value').css('font-size', Math.floor(element.find('> div').eq(0).width() * settings.style.textResponsive / 3) + 'px');
                element.find('.ClassyCountdown-value').each(function() {
                    $(this).css('margin-top', Math.floor(0 - (parseInt($(this).height()) / 2)) + 'px');
                });
            }
            $(window).trigger('resize');
            $(window).resize($.throttle(50, onResize));
        }

        function onResize() {
            element.find('.ClassyCountdown-wrapper > div').each(function() {
                $(this).css('height', $(this).width() + 'px');
            });
            if (settings.style.textResponsive) {
                element.find('.ClassyCountdown-value').css('font-size', Math.floor(element.find('> div').eq(0).width() * settings.style.textResponsive / 3) + 'px');
            }
            element.find('.ClassyCountdown-value').each(function() {
                $(this).css("margin-top", Math.floor(0 - (parseInt($(this).height()) / 2)) + 'px');
            });
            element.find('.ClassyCountdown-seconds input').trigger('change');
        }
        
        function getPreset(theme) {
           
              

        }
    };
})(jQuery);