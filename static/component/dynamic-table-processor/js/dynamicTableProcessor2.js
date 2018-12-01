/**
 * method：追加方法：all, append
 * setName：是否在字段控件上标注name属性，true标注，false不标注，默认不标注
 * lineCount：一行显示多少列
 * items: json对象，包括属性如下：
 * 		  displayName：界面显示名称
 *        inputName：控件名称
 *        displayStyle：空间显示样式（1 input, 5 dropdownlist,6 radio,7 checkbox,8 date）
 *        value：控件值
 *        description：描述信息
 *        styles:样式控制
 *        events：时间配置
 *        required：是否必填
 *        properties：属性可选项（目前radio、checkbox会用到），数组，包括属性如下：
 *                   value：值
 *                   name：名称
 */
(function($) {
	jQuery.fn.dynamicTable2 = function(options) {
		var defaults = {
			method : "all",
			setName : false,
			width : "100",
			lineCount : 4,
			dateFormat : "YYYY-mm-dd"
		};

		this.getFormData = function() {
			var jsonStr = "{";
			$.each(options.items, function(n, value) {
				if (n != 0) {
					jsonStr += ", ";
				}
				if (value.displayStyle == 3 || value.displayStyle == 6) {
					var val = $("input[name='" + value.inputName + "'][checked]").val();
					jsonStr += "\"" + value.inputName + "\": \"" + val + "\"";
				} else if (value.displayStyle == 7) {
					var chkValue = [];
					$("input[name='" + value.inputName + "']:checked").each(function() {
						chkValue.push($(this).val());
					});
					if (chkValue.length == 0) {
						jsonStr += "\"" + value.inputName + "\": \"0\"";
					} else {
						jsonStr += "\"" + value.inputName + "\": \"" + chkValue[0] + "\"";
					}
				} else {
					var val = $("#" + value.inputName).val();
					jsonStr += "\"" + value.inputName + "\": \"" + val + "\"";
				}
			});
			jsonStr += "}";
			return $.parseJSON(jsonStr);
		}

		this.getChangedItems = function() {
			$.each(options.items, function(n, value) {
				if (value.displayStyle == 3 || value.displayStyle == 6) {
					var val = $("input[name='" + value.inputName + "'][checked]").val();
					options.items[n]["value"] = val;
				} else if (value.displayStyle == 4 || value.displayStyle == 7) {
					var val = "";
					$.each($("input[name='" + value.inputName + "']:checked"), function(m, v) {
						if (m > 0) {
							val += "|";
						}
						val += v.value;
					});
					options.items[n]["value"] = val;
				} else {
					var val = $("#" + value.inputName).val();
					options.items[n]["value"] = val;
				}
			});
			return options.items;
		}

		this.destroy = function() {
			removeDiv(options.groupId);
		}

		var options = $.extend(defaults, options);
		return this.each(function() {
			var opts = options;
			var obj = $(this);

			var dynamicTableStr;

			var hiddenInputStr = "<div style='display:none;'>";

			var popoverObj = new Array();

			// 开关模式相关参数
			var onOffObjs = new Array();
			var onOffObjNames = new Array();
			var onOffObjParams = new Array();
			// radio模式相关参数
			var radioObjNames = new Array();
			// checkbox模式相关参数
			var checkboxObjNames = new Array();
			// select模式相关参数
			var dropdownlistObjNames = new Array();
			// radio模式2相关参数
			var radio2ObjNames = new Array();
			// checkbox模式2相关参数
			var checkbox2ObjNames = new Array();
			// date模式相关参数
			var dateObjNames = new Array();
			if (opts.items != undefined) {
				if (opts.method == "all") {
					dynamicTableStr = "<table id='" + opts.groupId + "'>";
				}
				var trFinished = true;
				var count = 0;// 隐藏字段个数，用于控制表格格式
				$.each(opts.items, function(n, value) {

					var style = "";
					if (value.styles != null && typeof (value.styles) != "undefined" && $.trim(value.styles.length) != 0) {
						var styles = JSON.parse(value.styles);
						if (typeof (styles) != "undefined") {
							$.each(styles, function(name, value) {
								style += name + ": " + value + ";";
							});
						}
					}
					// TEXT模式 不显示
					if (value.displayStyle == 0) {
						hiddenInputStr += value.displayName + ":";
						hiddenInputStr += "<input id='" + value.inputName + "' ";
						if (opts.setName) {
							hiddenInputStr += "name='" + value.inputName + "' ";
						}
						hiddenInputStr += "placeholder='" + value.displayName + "' class='form-control " + value.required + "' type='text' style='" + style + "' " + value.required + " value='" + value.value + "'/>";
						count++;
					}
					// 显示的字符串追加开始
					else {
						if ((n - count) % opts.lineCount == 0) {
							if (opts.method == "all") {
								dynamicTableStr += "<tr>";
							} else {
								dynamicTableStr += "<tr id='" + opts.groupId + "'>";
							}
							trFinished = false;
						}

						if (value.displayName == "") {
							dynamicTableStr += "<td colspan='2'>";
						} else {
							dynamicTableStr += "<td align='right' width='" + opts.width + "'>" + value.displayName + "：</td>";
							dynamicTableStr += "<td>";
						}
						if (value.displayStyle == undefined || value.displayStyle == 1) {
							// TEXT模式
							dynamicTableStr += "<input id='" + value.inputName + "' ";
							if (opts.setName) {
								dynamicTableStr += "name='" + value.inputName + "' ";
							}
							dynamicTableStr += "placeholder='" + value.displayName + "' class='form-control " + value.required + "' type='text' style='" + style + "' " + value.required + " value='" + value.value + "'/>";
						} else if (value.displayStyle == 2) {
							// 开关模式
							dynamicTableStr += "<div id='switch-div-" + value.inputName + "' class='switch' style='margin-left: 20px; margin-top: 5px;'>";
							dynamicTableStr += "<input id='" + value.inputName + "' ";
							if (opts.setName) {
								dynamicTableStr += "name='" + value.inputName + "' ";
							}
							dynamicTableStr += "type='checkbox' value='" + value.value + "'/>";
							dynamicTableStr += "</div>";
							onOffObjs[onOffObjs.length] = value;
							onOffObjNames[onOffObjNames.length] = value.inputName;
							onOffObjParams[onOffObjParams.length] = {
								onText : value.onName,
								offText : value.offName,
								onColor : opts.onColor,
								offColor : opts.offColor
							};
						} else if (value.displayStyle == 3) {
							// RADIO BUTTON模式
							$.each(opts.items[n]["properties"], function(m, prop) {
								dynamicTableStr += "<input id='" + value.inputName + "_" + m + "' name='" + value.inputName + "' value='" + prop.value + "' type='radio' style='margin-left: 20px; margin-top: 5px;'";
								if (prop.value == value.value) {
									dynamicTableStr += " checked='checked'";
								}
								dynamicTableStr += "/>";
								dynamicTableStr += "<label for='" + value.inputName + "_" + m + "' style='margin-left: 5px; font-weight: 400; cursor: pointer;'>" + prop.name + "</label>";
								radioObjNames[radioObjNames.length] = value.inputName + "_" + m;
							});
						} else if (value.displayStyle == 4) {
							// CHECKBOX模式
							// 将value.value转换为HashMap结构
							var map = new HashMap();
							try {
								var vals = value.value.split("|");
								if (vals != null && vals.length > 0) {
									$.each(vals, function(i, val) {
										map.put(val, val);
									});
								}
							} catch (e) {
							}
							$.each(opts.items[n]["properties"], function(m, prop) {
								dynamicTableStr += "<input id='" + value.inputName + "_" + m + "' name='" + value.inputName + "' value='" + prop.value + "' type='checkbox' style='margin-left: 20px;'";
								if (map.containsKey(prop.value)) {
									dynamicTableStr += " checked='checked'";
								}
								dynamicTableStr += "/>";
								dynamicTableStr += "<label for='" + value.inputName + "_" + m + "' style='margin-left: 5px; font-weight: 400; cursor: pointer;'>" + prop.name + "</label>";
								checkboxObjNames[checkboxObjNames.length] = value.inputName + "_" + m;
							});
						} else if (value.displayStyle == 5 || value.displayStyle == 15) {
							// DROPDOWNLIST模式
							dynamicTableStr += "<div id='" + value.inputName + "-dropdownlist" + "'></div>"
							dropdownlistObjNames[dropdownlistObjNames.length] = {
								id : value.inputName,
								ddlitems : opts.items[n]["properties"],
								relValue : value.value,
								events : value.events
							};
						} else if (value.displayStyle == 6) {
							// RADIO BUTTON模式：样式2
							$.each(opts.items[n]["properties"], function(m, prop) {
								dynamicTableStr += "<div style='margin-left: 20px; float: left; margin-top: 3px; margin-bottom: 0px;'>";
								dynamicTableStr += "<label id='label-" + value.inputName + "_" + m + "' style='font-weight: 400;'";
								if (value.description && value.description.length > 0 && value.description != "null") {
									dynamicTableStr += " data-container='body' data-original-title='提示' data-toggle='popover' data-placement='top' data-content='" + value.description + "'";
									popoverObj[popoverObj.length] = "label-" + value.inputName + "_" + m;
								}
								dynamicTableStr += ">";
								dynamicTableStr += "<input id='" + value.inputName + "_" + m + "' name='" + value.inputName + "' value='" + prop.value + "' type='radio' style='opacity: 0;" + style + "'";
								if (prop.value == value.value) {
									dynamicTableStr += " checked='checked'";
								}
								dynamicTableStr += "";
								dynamicTableStr += "/>";
								dynamicTableStr += prop.name;
								dynamicTableStr += "</label>";
								dynamicTableStr += "</div>";

								radio2ObjNames[radio2ObjNames.length] = value.inputName + "_" + m;
							});
						} else if (value.displayStyle == 7) {
							// CHECKBOX模式：样式2
							$.each(opts.items[n]["properties"], function(m, prop) {
								dynamicTableStr += "<div style='margin-left: 20px; float: left; margin-top: 3px; margin-bottom: 0px;'>";
								dynamicTableStr += "<label id='label-" + value.inputName + "_" + m + "' style='font-weight: 400;'";
								if (value.description && value.description.length > 0 && value.description != "null") {
									dynamicTableStr += " data-container='body' data-original-title='提示' data-toggle='popover' data-placement='top' data-content='" + value.description + "'";
									popoverObj[popoverObj.length] = "label-" + value.inputName + "_" + m;
								}
								dynamicTableStr += ">";
								dynamicTableStr += "<input id='" + value.inputName + "_" + m + "' name='" + value.inputName + "' value='" + prop.value + "' type='checkbox' style='opacity: 0;" + style + "'";
								if (prop.value == value.value) {
									dynamicTableStr += " checked='checked'";
								}
								dynamicTableStr += "";
								dynamicTableStr += "/>";
								dynamicTableStr += prop.name;
								dynamicTableStr += "</label>";
								dynamicTableStr += "</div>";

								checkbox2ObjNames[checkbox2ObjNames.length] = value.inputName + "_" + m;
							});
						} else if (value.displayStyle == 8) {
							// TEXT模式
							dynamicTableStr += "<input id='" + value.inputName + "' ";
							if (opts.setName) {
								dynamicTableStr += "name='" + value.inputName + "' ";
							}
							dynamicTableStr += "placeholder='" + value.displayName + "' class='form-control " + value.required + "' type='text' style='" + style + "'/>";
							dateObjNames[dateObjNames.length] = {
								id : value.inputName,
								relValue : value.value,
								events : value.events
							};
						}

						dynamicTableStr += "</td>";
						if ((n - count) % (opts.lineCount) == ((opts.lineCount) - 1)) {
							dynamicTableStr += "</tr>";
							trFinished = true;
						}
					}
				});

				// 字符串追加结束
				if (!trFinished) {
					dynamicTableStr += "<td colspan='2' align='right'></td></tr>";
				}
				if (opts.method == "all") {
					dynamicTableStr += "</table>";
				}

				hiddenInputStr += "</div>";
			}

			// 完全覆盖或者追加
			if (opts.method == "all") {
				obj.html(dynamicTableStr);
			} else if (opts.method == "append") {
				obj.append(dynamicTableStr);
			}
			obj.append(hiddenInputStr);

			// 开关模式下，启用switch插件并监听事件
			$.each(onOffObjNames, function(n, value) {
				$("#" + value).bootstrapSwitch(onOffObjParams[n]);
				if (onOffObjs[n].value == onOffObjs[n].onValue) {
					$("#" + value).bootstrapSwitch("state", true);
				}
				$("#switch-div-" + value).on('switchChange.bootstrapSwitch', function(e, data) {
					$("#" + value).val(data ? onOffObjs[n].onValue : onOffObjs[n].offValue);
				});
			});

			// radio模式下应用样式并监听checked事件
			$.each(radioObjNames, function(n, value) {
				$('#' + value).iCheck({
					checkboxClass : 'icheckbox_square-blue',
					radioClass : 'iradio_square-blue',
					increaseArea : '20%' // optional
				});
				$('#' + value).on('ifChecked', function(event) {
					$.each($("input[name='" + event.target.name + "']"), function(m, val) {
						if (val.id == event.target.id) {
							$('#' + val.id).attr("checked", true);
						} else {
							$('#' + val.id).attr("checked", false);
						}
					});
				});
			});

			// checkbox模式下应用样式并监听checked、unchecked事件
			$.each(checkboxObjNames, function(n, value) {
				$('#' + value).iCheck({
					checkboxClass : 'icheckbox_square-blue',
					radioClass : 'iradio_square-blue',
					increaseArea : '20%' // optional
				});
				$('#' + value).on('ifChecked', function(event) {
					$('#' + value).attr("checked", true);
				});
				$('#' + value).on('ifUnchecked', function(event) {
					$('#' + value).attr("checked", false);
				});
			});

			// dropdownlist模式下应用样式并监听dropDownList事件
			$.each(dropdownlistObjNames, function(n, value) {
				var ddlItems = new Array();
				ddlItems[ddlItems.length] = {
					itemText : "请选择",
					itemData : "0"
				};
				var ddlItemOjb = value.ddlitems;
				for ( var item in ddlItemOjb) {
					if (value.relValue == ddlItemOjb[item].value) {
						ddlItems[ddlItems.length] = {
							itemText : ddlItemOjb[item].name,
							itemData : ddlItemOjb[item].value,
							Selected : true
						};
					} else {
						ddlItems[ddlItems.length] = {
							itemText : ddlItemOjb[item].name,
							itemData : ddlItemOjb[item].value
						};
					}
				}

				ddlOrgTypeObj = $('#' + value.id + "-dropdownlist").dropDownList({
					inputName : value.id + 'Name',
					inputValName : value.id,
					buttonText : "",
					width : "117px",
					readOnly : false,
					inputReadOnly : true,
					required : true,
					maxHeight : 200,
					onSelect : function(i, data, icon) {

					},
					items : ddlItems
				});
			});

			// radio2模式下应用样式并监听click事件
			$.each(radio2ObjNames, function(n, value) {
				$('#' + value).uniform();
				$('#' + value).on('click', function(event) {
					$.each($("input[name='" + event.target.name + "']"), function(m, val) {
						if (val.id == event.target.id) {
							$('#' + val.id).attr("checked", true);
						} else {
							$('#' + val.id).attr("checked", false);
						}
					});
				});
			});

			// checkbox2模式下应用样式并监听click事件
			$.each(checkbox2ObjNames, function(n, value) {
				$('#' + value).uniform();
				$('#' + value).on('click', function(event) {
					$.each($("input[name='" + event.target.name + "']"), function(m, val) {
						if (val.id == event.target.id) {
							$('#' + val.id).attr("checked", true);
						} else {
							$('#' + val.id).attr("checked", false);
						}
					});
				});
			});

			// popover处理
			$.each(popoverObj, function(n, value) {
				$("#" + value).popover({
					trigger : "hover",
					placement : "right"
				});
			});

			// date模式下应用样式
			$.each(dateObjNames, function(n, value) {

				if (opts.dateFormat == "YYYY-mm-dd") {
					$("#" + value.id).datetimepicker({
						id : 'datetimepicker-' + value.id,
						containerId : 'datetimepicker-div',
						lang : 'ch',
						timepicker : false,
						format : 'Y-m-d',
						formatDate : 'YYYY-mm-dd'
					});
				} else {
					$("#" + value.id).datetimepicker({
						id : 'datetimepicker-' + value.id,
						containerId : 'datetimepicker-div',
						lang : 'ch',
						timepicker : true,
						format : 'Y-m-d H:i:s',
						formatDate : 'YYYY-mm-dd hh:mm:ss'
					});
				}
			});

		});
	}
})(jQuery);