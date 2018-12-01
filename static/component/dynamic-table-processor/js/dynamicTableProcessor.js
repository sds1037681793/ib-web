/**
 * columnWidth：字段宽度，单位为px
 * method：追加方法：all, append
 * setName：是否在字段控件上标注name属性，true标注，false不标注，默认不标注
 * onColor：开状态下的颜色样式
 * offColor：关状态下的颜色样式
 * items: json对象，包括属性如下：
 *        inputName：控件名称
 *        title：字段标题
 *        required：是否必填
 *        displayStyle：控件显示样式（1：text输入框，2：开关样式，3、6：单选框，4、7：多选框，5、15：下拉列表,16:下拉选择树）
 *        onName：开关样式中左侧选择时的名称
 *        onValue：开关样式中左侧选择时的值
 *        offName：开关样式中右侧选择时的名称
 *        offValue：开关样式中右侧选择时的值
 *        properties：属性可选项（目前单选框、多选框、下拉列表会使用），数组，包括属性如下：
 *                   value：值
 *                   name：名称
 *        value：控件值
 */
(function($) {
	jQuery.fn.dynamicTable = function(options) {
		var defaults = {
			columnWidth : "150",
			method : "all",
			onColor : "primary",
			offColor : "info",
			setName : false,
			width : "100",
			dateFormat : "YYYY-mm-dd hh:mm:ss",
			colPerRow : "2", // 每行显示字段数
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
				} else if (value.displayStyle == 4 || value.displayStyle == 7) {
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

		this.getSpecialFormData = function() {
			var jsonStr = "{";
			$.each(options.items, function(n, value) {
				if (n != 0) {
					jsonStr += ", ";
				}
				if (value.displayStyle == 3 || value.displayStyle == 6) {
					var val = $("input[name='" + value.inputName + "'][checked]").val();
					jsonStr += "\"" + value.inputName + "\": \"" + encodeURIComponent(encodeURIComponent(val)) + "\"";
				} else if (value.displayStyle == 4 || value.displayStyle == 7) {
					var chkValue = [];
					$("input[name='" + value.inputName + "']:checked").each(function() {
						chkValue.push($(this).val());
					});
					if (chkValue.length == 0) {
						jsonStr += "\"" + value.inputName + "\": \"0\"";
					} else {
						jsonStr += "\"" + value.inputName + "\": \"" + encodeURIComponent(encodeURIComponent(chkValue[0])) + "\"";
					}
				} else {
					var val = $("#" + value.inputName).val();
					jsonStr += "\"" + value.inputName + "\": \"" +  encodeURIComponent(encodeURIComponent(val)) + "\"";
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

			// 动态表格html字符串
			var dynamicTableStr = "";

			// 隐藏字段html字符串
			var hiddenInputStr = "<div style='display:none;'>";

			// 开关字段数组
			var switchObjects = new Array();
			// 单选框字段数组
			var radioButtonObjects = new Array();
			// 多选框字段数组
			var checkBoxObjects = new Array();
			// 下拉列表字段数组
			var dropdownlistObjects = new Array();
			// 下拉列表选择树数组
			var dropdowntreeObjects = new Array();
			// 日期字段数组
			var dateObjects = new Array();
			// 弹出框对象数组
			var popoverObjects = new Array();
			// 事件对象（字段配置的属性events）
			var eventObjects = new Array();

			if (opts.items != undefined) {
				if (opts.method == "all") {
					dynamicTableStr = "<table id='" + opts.groupId + "'>";
				}
				var trFinished = true;
				var count = 0;// 隐藏字段个数，用于控制表格格式
				$.each(opts.items, function(n, value) {
					// TEXT模式 不显示
					if (value.displayStyle == 0) {
						hiddenInputStr += addHiddenItem(value, opts);
						count++;
					} else {
						if ((n - count) % opts.colPerRow == 0) {
							if (opts.method == "all") {
								dynamicTableStr += "<tr>";
							} else {
								dynamicTableStr += "<tr id='" + opts.groupId + "'>";
							}
							trFinished = false;
						}

						if (value.title == "") {
							dynamicTableStr += "<td colspan='2'>";
						} else {
							dynamicTableStr += "<td align='right' width='" + opts.width + "'>" + value.title + "：</td>";
							dynamicTableStr += "<td>";
						}

						// 获取字段样式
						value.styles = getStyles(value);

						// 生成字段
						if (value.displayStyle == undefined || value.displayStyle == 1) {
							// TEXT字段
							dynamicTableStr += addTextItem(value, opts);
						} else if (value.displayStyle == 2) {
							// 开关字段
							dynamicTableStr += addSwitchItem(value, opts);
							switchObjects[switchObjects.length] = addSwitchObject(value, opts);
						} else if (value.displayStyle == 3 || value.displayStyle == 6) {
							// 单选框字段
							dynamicTableStr += addRadioButtonItem(value, opts);
							radioButtonObjects = radioButtonObjects.concat(addRadioButtonObject(value, opts));
							popoverObjects = popoverObjects.concat(addPopoverObject(value, opts));
						} else if (value.displayStyle == 4 || value.displayStyle == 7) {
							// 多选框字段
							dynamicTableStr += addCheckBoxItem(value, opts);
							checkBoxObjects = checkBoxObjects.concat(addCheckBoxObject(value, opts));
							popoverObjects = popoverObjects.concat(addPopoverObject(value, opts));
						} else if (value.displayStyle == 5 || value.displayStyle == 15) {
							// 下拉列表字段
							dynamicTableStr += addDropdownlistItem(value);
							dropdownlistObjects = dropdownlistObjects.concat(addDropdownlistObject(value, opts));
						} else if (value.displayStyle == 16) {
							// 下拉选择树
							dynamicTableStr += addDropdownTreeItem(value, opts);
							dropdowntreeObjects = dropdowntreeObjects.concat(addDropdowntreeObject(value, opts));
						} else if (value.displayStyle == 8) {
							// 日期字段
							dynamicTableStr += addDateItem(value, opts);
							dateObjects = dateObjects.concat(addDateObject(value));
						} else if (value.displayStyle == 9) {
							// 占位字段
							dynamicTableStr += addPlaceholderItem();
						} else if (value.displayStyle == 10) {
							// 按钮字段
							dynamicTableStr += addButtonItem(value);
							eventObjects = eventObjects.concat(addEventObject(value));
						} else if (value.displayStyle == 11) {
							// 按钮组字段
							dynamicTableStr += addButtonItems(value);
							eventObjects = eventObjects.concat(addButtonEventObjects(value));
						}

						dynamicTableStr += "</td>";
						if ((n - count) % opts.colPerRow == opts.colPerRow - 1) {
							dynamicTableStr += "</tr>";
							trFinished = true;
						}
					}
				});
				if (!trFinished) {
					dynamicTableStr += "<td></td></tr>";
				}
				if (opts.method == "all") {
					dynamicTableStr += "</table>";
				}

				hiddenInputStr += "</div>";
			}

			if (opts.method == "all") {
				// 完全覆盖模式
				obj.html(dynamicTableStr);
			} else if (opts.method == "append") {
				// 追加模式
				obj.append(dynamicTableStr);
			}
			obj.append(hiddenInputStr);

			// 如果有时间字段，且div（datetimepicker-div）不存在，则生成一个（用于生成时间选择对象）
			if (dateObjects.length > 0 && !$("#datetimepicker-div").length > 0) {
				obj.append("<div id='datetimepicker-div'></div>")
			}

			// 开关字段，启用switch插件并监听事件
			switchApplyAndEventListening(switchObjects);

			// 下拉列表字段，监听dropDownList事件
			dropdownlistApplyAndEventListening(dropdownlistObjects);

			// 下拉树字段，监听treeSelecter事件
			dropdownTreeSelecterApply(dropdowntreeObjects);

			// 单选框字段，监听click事件
			radioButtonEventListening(radioButtonObjects);

			// 多选框字段，监听click事件
			checkBoxEventListening(checkBoxObjects);

			// 日期字段，样式应用
			dateApply(dateObjects, opts);

			// popover处理
			popover(popoverObjects);

			// 字段事件（字段属性events）监听
			eventListening(eventObjects);
		});
	}

	/**
	 * 新增隐藏字段
	 * @param item 数据对象
	 * @param opts 控制参数
	 */
	addHiddenItem = function(item, opts) {
		var result = item.title + ":";
		result += "<input id='" + item.inputName + "' ";
		if (opts.setName) {
			result += "name='" + item.inputName + "' ";
		}
		result += "placeholder='" + item.title + "' class='form-control' type='text' value='" + item.value + "'/>";
		return result;
	}

	/**
	 * 新增文本框字段
	 * @param item 数据对象
	 * @param opts 控制参数
	 */
	addTextItem = function(item, opts) {
		var result = "<input id='" + item.inputName + "' ";
		if (opts.setName) {
			result += "name='" + item.inputName + "' ";
		}

		var required = "";
		if (item.required && item.required.length > 0) {
			required = item.required;
		}

		var style = item.styles;
		if (!style || style.length <= 0) {
			style = "width: " + opts.columnWidth + "px;";
		}

		result += "placeholder='" + item.title + "' class='form-control " + required + "' type='text' style='" + style + "' " + required + " value='" + item.value + "'/>";
		return result;
	}

	/**
	 * 新增开关字段
	 * @param item 数据对象
	 * @param opts 控制参数
	 */
	addSwitchItem = function(item, opts) {
		var result = "<div id='switch-div-" + item.inputName + "' class='switch' style='margin-left: 20px; margin-top: 5px;'>";
		result += "<input id='" + item.inputName + "' ";
		if (opts.setName) {
			result += "name='" + item.inputName + "' ";
		}
		result += "type='checkbox' value='" + item.value + "'/>";
		result += "</div>";
		return result;
	}

	/**
	 * 缓存开关对象
	 * @param item 数据对象
	 * @param opts 控制参数
	 * @returns
	 */
	addSwitchObject = function(item, opts) {
		return {
			item : item,
			params : {
				onText : item.onName,
				offText : item.offName,
				onColor : opts.onColor,
				offColor : opts.offColor
			}
		};
	}

	/**
	 * 新增单选框字段
	 * @param item 数据对象
	 * @param opts 控制参数
	 */
	addRadioButtonItem = function(item, opts) {
		var result = "";
		$.each(item["properties"], function(m, prop) {
			result += "<div style='margin-left: 20px; float: left; margin-top: 3px; margin-bottom: 0px;'>";
			result += "<label id='label-" + item.inputName + "_" + m + "' style='font-weight: 400;'";
			if (item.description && item.description.length > 0 && item.description != "null") {
				result += " data-container='body' data-original-title='提示' data-toggle='popover' data-placement='top' data-content='" + item.description + "'";
			}
			result += ">";
			result += "<input id='" + item.inputName + "_" + m + "' name='" + item.inputName + "' value='" + prop.value + "' type='radio' style='opacity: 0;'";
			if (prop.value == item.value) {
				result += " checked='checked'";
			}
			result += "";
			result += "/>";
			result += prop.name;
			result += "</label>";
			result += "</div>";
		});
		return result;
	}

	/**
	 * 新增单选框对象
	 * @param item 数据对象
	 * @param opts 控制参数
	 */
	addRadioButtonObject = function(item, opts) {
		var radioButtonObjects = new Array();
		$.each(item["properties"], function(m, prop) {
			radioButtonObjects[radioButtonObjects.length] = item.inputName + "_" + m;
		});
		return radioButtonObjects;
	}

	/**
	 * 新增多选框字段
	 * @param item 数据对象
	 * @param opts 控制参数
	 */
	addCheckBoxItem = function(item, opts) {
		// 将item.value转换为HashMap结构
		var map = new HashMap();
		try {
			var vals = item.value.split("|");
			if (vals != null && vals.length > 0) {
				$.each(vals, function(i, val) {
					map.put(val, val);
				});
			}
		} catch (e) {
		}

		var result = "";
		$.each(item["properties"], function(m, prop) {
			result += "<div style='margin-left: 20px; float: left; margin-top: 3px; margin-bottom: 0px;'>";
			result += "<label id='label-" + item.inputName + "_" + m + "' style='font-weight: 400;'";
			if (item.description && item.description.length > 0 && item.description != "null") {
				result += " data-container='body' data-original-title='提示' data-toggle='popover' data-placement='top' data-content='" + item.description + "'";
			}
			result += ">";
			result += "<input id='" + item.inputName + "_" + m + "' name='" + item.inputName + "' value='" + prop.value + "' type='checkbox' style='opacity: 0;'";
			if (map.containsKey(prop.value)) {
				result += " checked='checked'";
			}
			result += "";
			result += "/>";
			result += prop.name;
			result += "</label>";
			result += "</div>";
		});
		return result;
	}

	/**
	 * 新增多选框对象
	 * @param item 数据对象
	 * @param opts 控制参数
	 */
	addCheckBoxObject = function(item, opts) {
		var checkBoxObjects = new Array();
		$.each(item["properties"], function(m, prop) {
			checkBoxObjects[checkBoxObjects.length] = item.inputName + "_" + m;
		});
		return checkBoxObjects
	}

	/**
	 * 新增下拉列表字段
	 * @param item 数据对象
	 * @returns
	 */
	addDropdownlistItem = function(item) {
		return "<div id='" + item.inputName + "-dropdownlist" + "'></div>";
	}

	/**
	 * 新增下拉选择数对象
	 * @param item 数据对象
	 * @returns
	 */
	addDropdownTreeItem = function(item, opts) {
		var htmlStr = "<div id='" + item.inputName + "_tree' class='tree-selecter'>";
		htmlStr += "<div class='input-group'>";
		htmlStr += "<input id='" + item.inputName + "' name='" + item.inputName + "' class='treeFieldId' type='hidden' value=''>";
		htmlStr += "<input id='" + item.inputName + "_name' type='text' value='' class='form-control treeFieldName' style ='width:" + opts.columnWidth + "px;' placeholder='" + item.title + "' autocomplete='off'>";
		htmlStr += "<div class='treeContent box-borderd'>";
		htmlStr += "<ul id='" + item.inputName + "_tree' class='ztree'></ul>";
		htmlStr += "</div>";
		htmlStr += "<span class='input-group-btn selecter'>";
		htmlStr += "<a href='#' class='clearBtn'>";
		htmlStr += "<span class='glyphicon glyphicon-remove' style ='font-size: 9px;color: #6e6868e6;'></span>";
		htmlStr += "</a>";
		htmlStr += "</span>";
		htmlStr += "</div>";
		htmlStr += "</div>";
		return htmlStr;
	}

	/**
	 * 新增下拉列表对象
	 * @param item 数据对象
	 * @param opts 控制参数
	 * @returns
	 */
	addDropdownlistObject = function(item, opts) {
		return {
			id : item.inputName,
			ddlitems : item["properties"],
			relValue : item.value
		};
	}

	/**
	 * 新增下拉树对象
	 * @param item 数据对象
	 * @param opts 控制参数
	 * @returns
	 */
	addDropdowntreeObject = function(item, opts) {
		var grpid = "#" + opts.groupId + " #" + item.inputName + "_tree";
		return {
			groupId : grpid,
			zNodes : item["mapProperties"],
			defaultValue : item.value
		};
	}

	/**
	 * 新增日期字段
	 * @param item
	 * @param opts
	 * @returns
	 */
	addDateItem = function(item, opts) {
		var result = "<input id='" + item.inputName + "' ";
		if (opts.setName) {
			result += "name='" + item.inputName + "' ";
		}

		var required = "";
		if (item.required && item.required.length > 0) {
			required = item.required;
		}

		var style = item.styles;
		if (!style || style.length <= 0) {
			style = "width: " + opts.columnWidth + "px;";
		}

		result += "placeholder='" + item.title + "' class='form-control " + required + "' type='text' style='" + style + "' value='" + item.value + "'/>";
		return result;
	}

	/**
	 * 新增日期对象
	 * @param item
	 * @returns
	 */
	addDateObject = function(item) {
		return {
			id : item.inputName,
			relValue : item.value,
			events : item.events
		};
	}

	/**
	 * 新增占位字段
	 * @returns
	 */
	addPlaceholderItem = function() {
		return "";
	}

	/**
	 * 新增按钮字段
	 * @param item
	 * @param opts
	 */
	addButtonItem = function(item) {
		return "<button id='" + item.inputName + "' type='button' class='btn btn-default btn-common' style='" + item.styles + "'>" + item.description + "</button>";
	}

	/**
	 * 新增多个按钮字段
	 * @param item
	 * @param opts
	 */
	addButtonItems = function(item) {
		var htmls = "";
		if (item.events && item.events.length > 0) {
			var events = JSON.parse(item.events);
			if (typeof (events) != "undefined") {
				$.each(events, function(name, value) {
					if (htmls == "") {
						htmls += "<button id='" + value.buttonName + "' type='button' class='btn btn-default btn-common' style='margin-left: 6.5rem;'>" + value.description + "</button>";
					} else {
						htmls += "<button id='" + value.buttonName + "' type='button' class='btn btn-default btn-common'style='margin-left: 10px;'>" + value.description + "</button>";
					}

				});
			}
		}
		return htmls;
	}

	/**
	 * 获取字段样式
	 * @param item
	 * @returns
	 */
	getStyles = function(item) {
		var result = "";
		if (item.styles != null && typeof (item.styles) != "undefined" && $.trim(item.styles.length) != 0) {
			var styles = JSON.parse(item.styles);
			if (typeof (styles) != "undefined") {
				$.each(styles, function(name, value) {
					result += name + ": " + value + ";";
				});
			}
		}
		return result;
	}

	/**
	 * 新增弹出框（Popover）对象
	 * @param item 数据对象
	 * @param opts 控制参数
	 */
	addPopoverObject = function(item, opts) {
		var popoverObject = new Array();
		$.each(item["properties"], function(m, prop) {
			if (item.description && item.description.length > 0 && item.description != "null") {
				popoverObject[popoverObject.length] = "label-" + item.inputName + "_" + m;
			}
		});
		return popoverObject;
	}

	/**
	 * 新增事件对象
	 * @param item
	 * @returns
	 */
	addEventObject = function(item) {
		var eventObjects = new Array();
		if (item.events && item.events.length > 0) {
			var events = JSON.parse(item.events);
			if (typeof (events) != "undefined") {
				$.each(events, function(name, value) {
					eventObjects[eventObjects.length] = {
						id : item.inputName,
						event : value.event,
						func : value.func
					};
				});
			}
		}
		return eventObjects;
	}

	/**
	 * 新增按钮组事件对象
	 * @param item
	 * @returns
	 */
	addButtonEventObjects = function(item) {
		var eventObjects = new Array();
		if (item.events && item.events.length > 0) {
			var events = JSON.parse(item.events);
			if (typeof (events) != "undefined") {
				$.each(events, function(name, value) {
					eventObjects[eventObjects.length] = {
						id : value.buttonName,
						event : value.event,
						func : value.func
					};
				});
			}
		}
		return eventObjects;
	}

	/**
	 * 开关按钮应用及事件监听
	 * @param switchObjects
	 */
	switchApplyAndEventListening = function(switchObjects) {
		$.each(switchObjects, function(n, value) {
			$("#" + value.item.inputName).bootstrapSwitch(value.params);
			if (value.item.value == value.item.onValue) {
				$("#" + value.item.inputName).bootstrapSwitch("state", true);
			}
			$("#switch-div-" + value.item.inputName).on('switchChange.bootstrapSwitch', function(e, data) {
				$("#" + value.item.inputName).val(data ? value.item.onValue : value.item.offValue);
			});
		});
	}

	/**
	 * 单选框监听事件
	 * @param radioButtonObjects
	 */
	radioButtonEventListening = function(radioButtonObjects) {
		$.each(radioButtonObjects, function(n, value) {
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
	}

	/**
	 * 下拉列表应用及事件监听
	 * @param dropdowntreeObjects
	 */
	dropdownTreeSelecterApply = function(dropdowntreeObjects) {
		$.each(dropdowntreeObjects, function(n, value) {
			treeSelecter(value.groupId, value.zNodes, value.defaultValue);
		});
	}

	dropdownlistApplyAndEventListening = function(dropdownlistObjects) {
		$.each(dropdownlistObjects, function(n, value) {
			var ddlItems = new Array();
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
				required : true,
				maxHeight : 200,
				onSelect : function(i, data, icon) {

				},
				items : ddlItems
			});
		});
	}

	/**
	 * 多选框事件监听
	 * @param checkBoxObjects
	 */
	checkBoxEventListening = function(checkBoxObjects) {
		$.each(checkBoxObjects, function(n, value) {
			$('#' + value).uniform();
			$('#' + value).on('click', function(event) {
				$.each($("input[name='" + event.target.name + "']"), function(m, val) {
					if (val.id == event.target.id) {
						if ($('#' + val.id).get(0).checked) {
							$('#' + val.id).attr("checked", true);
						} else {
							$('#' + val.id).attr("checked", false);
						}
					}
				});
			});
		});
	}

	/**
	 * 日期样式应用
	 * @param dateObjects
	 * @param opts
	 */
	dateApply = function(dateObjects, opts) {
		$.each(dateObjects, function(n, value) {
			if (opts.dateFormat == "YYYY-mm-dd") {
				$("#" + value.id).datetimepicker({
					id : 'datetimepicker-' + value.id,
					containerId : 'datetimepicker-div',
					lang : 'ch',
					timepicker : false,
					format : 'Y-m-d',
					value : value.relValue,
					formatDate : 'YYYY-mm-dd'
				});
			} else {
				$("#" + value.id).datetimepicker({
					id : 'datetimepicker-' + value.id,
					containerId : 'datetimepicker-div',
					lang : 'ch',
					timepicker : true,
					value : value.relValue,
					format : 'Y-m-d H:i:s',
					formatDate : 'YYYY-mm-dd hh:mm:ss'
				});
			}
		});
	}

	/**
	 * 事件监听（字段配置的events属性）
	 * @param eventObjects
	 */
	eventListening = function(eventObjects) {
		$.each(eventObjects, function(n, value) {
			$("#" + value.id).bind(value.event, function() {
				eval(value.func);
			});
		});
	}

	/**
	 * popover处理
	 * @param popoverObjects
	 */
	popover = function(popoverObjects) {
		$.each(popoverObjects, function(n, value) {
			$("#" + value).popover({
				trigger : "hover",
				placement : "right"
			});
		});
	}

})(jQuery);