function treeSelecterByURL2(url, groupId, method, defaultValue) {
	var treeObj;
	var group = $(groupId);
	var idField = group.find('.treeFieldId');
	var nameField = group.find('.treeFieldName');
	var treeField = group.find('.treeContent .ztree');
	var treeId = treeField.attr('id');
	var clearButton = group.find('.clearBtn');
	if (typeof method == 'undefined') {
		method = 'GET'
	}
	var setting = {
		view : {
			showLine : false
		},
		data : {
			simpleData : {
				enable : true
			}
		},
		callback : {
			onClick : function(event, treeId, treeNode) {
				var node = treeNode, name = '';
//				while (node != null) {
//					name = name.length != 0 ? node.name + " > " + name
//							: node.name;
//					node = node.getParentNode();
//				}
				name = node.name;
				idField.val(treeNode.id);
				nameField.val(name);
				hideMenu();
				showAttrPage(treeNode.id);
				treeObj.expandAll(false);
			},
		}
	};
	clearButton.click(function() {
		var $inputGroup = $(this).parents('.input-group');
		$inputGroup.find('input').val('');
		treeObj.expandAll(false);
		var nodes = treeObj.getSelectedNodes();
		if (nodes.length > 0) {
			treeObj.cancelSelectedNode(nodes[0]);
		}
		return false
	})
	$.ajax({
				method : method,
				url : url,
				data : {},
				dataType : "json",
				success : function(data) {
					treeObj = $.fn.zTree.init(treeField, setting, data);
					hideMenu(); 
					nameField.click(function() {
						hideMenu();
						treeObj = $.fn.zTree.init(treeField, setting, data);
						showMenu(group);
						var nodes = treeObj.getSelectedNodes();
						if (nodes.length > 0) {
							treeObj.expandNode(nodes[0].getParentNode(), true,
									true, true);
						}
					});

					nameField
							.keyup(function() {
								if (nameField.val().length > 0) {

									// 显示上次搜索后背隐藏的结点
									// hiddenNodes =
									// treeObj.getNodesByParam("isHidden",
									// true);
									treeObj.showNodes(hiddenNodes);
									// 查找不符合条件的叶子节点
									function filterFunc(node) {
										var _keywords = nameField.val();
										if (node.isParent
												|| node.name.indexOf(_keywords) != -1)
											return false;
										return true;
									}
									;

									// 获取不符合条件的叶子结点
									hiddenNodes = treeObj
											.getNodesByFilter(filterFunc);

									// 隐藏不符合条件的叶子结点
									treeObj.hideNodes(hiddenNodes);
								} else {
									// 隐藏树
									// hideMenu();
									treeObj = $.fn.zTree.init(treeField,
											setting, data);
								}
							});

					// 设置了默认值
					if (typeof defaultValue != "undefined") {
						var nodeName = '';
						var treeNode = treeObj.getNodeByParam("id",
								defaultValue, null);
						if (treeNode != null) {
							var node = treeNode;
							while (node != null) {
								nodeName = nodeName.length != 0 ? node.name
										+ " > " + nodeName : node.name;
								node = node.getParentNode();
							}
							idField.val(treeNode.id);
							nameField.val(nodeName);
							treeObj.selectNode(treeNode, false, false);
						}
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", "初始化功能数据失败！");
				}
			})
}

	function showMenu(group) {
		var treeField = group.find('.treeContent .ztree');
		treeField.parents('.treeContent').css({
			width : group.find('.input-group').first().outerWidth() + 'px'
		}).slideDown('fast');
		$('body').bind('mousedown', onBodyDown);
	}
	function hideMenu() {
		$('.treeContent').fadeOut('fast');
		$('body').unbind('mousedown', onBodyDown);
	}
	function onBodyDown(event) {
		if (!(event.target.id == 'menuBtn'
				|| $(event.target).hasClass('treeContent') || $(event.target)
				.parents('.treeContent').length > 0)) {
			hideMenu();
		}
	}
	function showAttrPage(typeId){
		$("#attrLi").show();
		dataTypeInit(typeId);
	}
	
