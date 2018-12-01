(function($){
	jQuery.fn.dropDownList = function(options) {
		var defaults = {
			inputName: "Q",
			inputValName: "",
			buttonText: "示例",
			readOnly: true,
			inputReadOnly: true,
			required: false,
			maxHeight: -1,
			width: "200px",
			onSelect: $.noop(),
			selfAdaption : false,
			search : false
		};

		var paddingLeftAdd = 20;
		var isIE = !!window.ActiveXObject || "ActiveXObject" in window;

		this.disable = function() {
			$("#" + options.inputName).attr("disabled", true);
			$("#ddl-btn-" + options.inputName).attr("disabled", true);
		},
		this.enable = function() {
			$("#" + options.inputName).attr("disabled", false);
			$("#ddl-btn-" + options.inputName).attr("disabled", false);
		}
		var inputPaddingLeft;
		this.setData = function(text, data, icon) {
			var input = $(this).find("#" + options.inputName);
			var ulObj = $(this).find("#" + options.inputName + "-ul");
			input.val(text);
			var inputIconSpan = $("#icon-span-" + options.inputName);
			if (icon !== undefined && icon.length > 0) {
				inputIconSpan.attr("class", icon);
				input.css("padding-left", (inputPaddingLeft + paddingLeftAdd ) + "px");
				if (!isIE) {
					ulObj.css("margin-right", "-" + (inputPaddingLeft + paddingLeftAdd ) + "px");
					if(options.selfAdaption){
						ulObj.css("width",  (parseInt(options.width.replace("px","")) + 32)+"px");
						$(".dropdown-menu").css("min-width",  (parseInt(options.width.replace("px","")) + 32)+"px");
					}
				}
			} else {
				inputIconSpan.attr("class", "");
				input.css("padding-left", inputPaddingLeft + "px");
				if (!isIE) {
					ulObj.css("margin-right", "-" + (inputPaddingLeft + paddingLeftAdd ) + "px");
					if(options.selfAdaption){
						ulObj.css("width",  (parseInt(options.width.replace("px","")) + 32)+"px");
						$(".dropdown-menu").css("min-width",  (parseInt(options.width.replace("px","")) + 32)+"px");
					}
				}
			}
			if (options.inputValName.length > 0) {
				var inputVal = $(this).find("#" + options.inputValName);
				inputVal.val(data);
			}
		}

		var options = $.extend(defaults, options);
		return this.each(function() {
			var opts = options;
			var obj = $(this);
			var requiredStr = "";
			if (opts.required) {
				requiredStr = "required";
			}
			var dropDownListStr = "<div class='input-group'>";
			dropDownListStr = dropDownListStr + "<span id='icon-span-" + opts.inputName + "' class='' style='position: absolute; z-index: 3; font-size: 24px; top: 5px; display: block;'></span>";
			dropDownListStr = dropDownListStr + "<input type='text' class='form-control' name='" + opts.inputName + "' id='" + opts.inputName + "' style='width: " + opts.width + ";' " + requiredStr + " />";
			if (opts.inputValName.length > 0) {
				dropDownListStr = dropDownListStr + "<input type='text' name='" + opts.inputValName + "' id='" + opts.inputValName + "' style='display:none;' />";
			}
			dropDownListStr = dropDownListStr + "<div class='input-group-btn' style='position: static;'>";
			dropDownListStr = dropDownListStr + "<button id='ddl-btn-" + opts.inputName + "' type='button' class='btn btn-default dropdown-toggle' data-toggle='dropdown'>" + opts.buttonText + " <span class='caret'></span></button>";
			dropDownListStr = dropDownListStr + "<ul id='" + opts.inputName + "-ul' class='dropdown-menu dropdown-menu-right' role='menu' >";
			dropDownListStr = dropDownListStr + "<li><ul id='" + opts.inputName + "-ul-li-ul' class='dropdown-menu ' style='display:inherit;position:inherit;top:0;float:inherit;padding:0;border:0px;border-radius:0px;-webkit-box-shadow: inherit;box-shadow: inherit;'>";
			if(opts.search){
				dropDownListStr = dropDownListStr + "<input id='search' name='search' class='form-control' type='text' style='border-bottom-right-radius: 3px;border-top-right-radius: 3px;margin-bottom: 10px;margin-left: 10px;margin-right: 20px;width:"+opts.width+";'  />";
			}

			var selText, selData, selIcon;
			if (opts.sections !== undefined) {
				$.each(opts.sections, function(n, value) {
					if (n > 0) {
						dropDownListStr = dropDownListStr + "<li class='divider'></li>";
					}
					if (value.itemHeader !== undefined) {
						dropDownListStr = dropDownListStr + "<li class='dropdown-header'>" + value.itemHeader + "</li>";
					}
					createItem(value);
				});
			} else {
				createItem(opts);
			}

			function createItem(items) {
				$.each(items.items, function(n, item) {
					if (item.itemData === undefined) {
						item.itemData = item.itemText;
					}
					var span = "";
					if (item.itemIcon !== undefined && item.itemIcon != null && item.itemIcon != "") {
						span = "<span class='" + item.itemIcon + "' style='padding-right: 5px;'></span>";
					}

					if(opts.selfAdaption){
						if(opts.width && parseInt(opts.width.replace("px","")) + 32 <= 12 * item.itemText.length){
							var num = (parseInt(opts.width.replace("px","")) + 32) / 12;
							dropDownListStr = dropDownListStr + "<li><a href='#' onclick='return false;' title='" + item.itemText + "' itemData='" + item.itemData+"' itemText='" + item.itemText + "' itemIcon='" + item.itemIcon + "' >" + span + item.itemText.substring(0, num-4) + "..." + "</a></li>";
						} else{
							dropDownListStr = dropDownListStr + "<li><a href='#' onclick='return false;' title='" + item.itemText + "' itemData='" + item.itemData+"' itemText='" + item.itemText + "' itemIcon='" + item.itemIcon + "' >" + span + item.itemText + "</a></li>";
						}
					}else{
						dropDownListStr = dropDownListStr + "<li><a href='#' onclick='return false;' itemData='" + item.itemData+"' itemText='" + item.itemText + "' itemIcon='" + item.itemIcon + "' >" + span + item.itemText + "</a></li>";
					}
					if (item.Selected == true) {
						selText = item.itemText;
						selData = item.itemData;
						selIcon = item.itemIcon;
					}
				});
			}

			dropDownListStr = dropDownListStr + "</ul></li></ul></div></div>";
			obj.html(dropDownListStr);

			$("#search").on("click", function(event) {
				event.stopPropagation();
			});

			$("#search").on("keyup", function(event) {
				$("#" + options.inputName + "-ul-li-ul li a").each(function(index, element) {
					if($("#search").val() != "" && $(this).attr("itemText").indexOf($("#search").val())){
						$(this).css("display","none");
					}else{
						$(this).css("display","block");
					}
			    });
			});

			var input = obj.find("#" + opts.inputName);
			var ulObj = obj.find("#" + opts.inputName + "-ul");
			inputPaddingLeft = parseInt(input.css("padding-left"));
			var inputIconSpan = obj.find($("#icon-span-" + opts.inputName));
			inputIconSpan.css("marginLeft", (paddingLeftAdd + inputPaddingLeft) + "px");
			if (selText != "") {
				setData(selText, selData, selIcon);
			}
			obj.find("a").bind("click", function(e) {
				setData($(this).attr("itemText"), $(this).attr("itemData"), $(this).attr("itemIcon"));
			});
			if (opts.readOnly == true) {
				input.bind("cut copy paste keydown", function(e) {
					e.preventDefault();
				});
				$("#" + options.inputName).attr("disabled", true);
				$("#ddl-btn-" + options.inputName).attr("disabled", true);
			} else if (opts.inputReadOnly == true) {
				$("#" + options.inputName).attr("readonly", "readonly");
			}
			if (opts.maxHeight > 0) {
				var ul = obj.find("#" + options.inputName + "-ul-li-ul");
				ul.css({'max-height': opts.maxHeight + "px", 'overflow': 'auto'});
			}
			function setData(text, data, icon) {
				input.val(text);
				if (icon !== undefined && icon !== "undefined" && icon.length > 0) {
					inputIconSpan.attr("class", icon);
					input.css("padding-left", (inputPaddingLeft + paddingLeftAdd ) + "px");
					if (!isIE) {
						ulObj.css("margin-right", "-" + (inputPaddingLeft + paddingLeftAdd ) + "px");
						if(opts.selfAdaption){
							ulObj.css("width",  (parseInt(opts.width.replace("px","")) + 32)+"px");
							$(".dropdown-menu").css("min-width",  (parseInt(opts.width.replace("px","")) + 32)+"px");
						}
					}
				} else {
					inputIconSpan.attr("class", "");
					input.css("padding-left", inputPaddingLeft + "px");
					if (!isIE) {
						ulObj.css("margin-right", "-" + (inputPaddingLeft + paddingLeftAdd ) + "px");
						if(opts.selfAdaption){
							ulObj.css("width",  (parseInt(opts.width.replace("px","")) + 32)+"px");
							$(".dropdown-menu").css("min-width",  (parseInt(opts.width.replace("px","")) + 32)+"px");
						}
					}
				}
				if (opts.onSelect) {
					opts.onSelect(opts.inputName, data, icon);
				}
				if (opts.inputValName.length > 0) {
					var inputVal = obj.find("#" + opts.inputValName);
					inputVal.val(data);
				}
			}
		});
	}
})(jQuery);