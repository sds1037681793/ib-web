<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<form id="org-form-edit">
	<table id="org-form-table" style="width:100%;">
		<tr>
			<td align="right" style="width:13rem;">组织名称：</td>
			<td>
				<input id="organizeName" name="organizeName" placeholder="组织名称" class="form-control required" type="text" style="width: 150px;" required />
				<input id="state" name="state" type="text" style="display: none;" />
				<input id="id" name="id" type="text" style="display: none;" />
			</td>
			<td align="right" style="width:16rem;">组织编码：</td>
			<td>
				<input id="organizeCode" name="organizeCode" placeholder="组织编码" class="form-control required" type="text" style="width: 150px;" required />
			</td>
		</tr>
		<tr>
			<td align="right">上级组织：</td>
			<td>
				<div style="width: 30%">
					<div class="input-group">
						<input id="parentOrganizeId" name="parentOrganizeId" type="text" style="display: none;" />
						<input id="parentOrganizeName" name="parentOrganizeName" placeholder="上级组织" class="form-control" type="text" style="width: 117px;" readonly />
						<span class="input-group-btn" style="display: block">
							<button id="btn-select-org" class="btn btn-default btn-input" type="button" data-toggle="modal" data-target="#select-org-modal">+</button>
						</span>
					</div>
				</div>
			</td>
			<td align="right">组织类型：</td>
			<td>
				<div id="organize-type-dropdownlist"></div>
			</td>
		</tr>
	</table>
</form>
<script>
	var ddlOrgTypeObj;
	// var dropDownListOrgTypes = new HashMap();
	var dynamicTableObj;
	$(document).ready(function() {

		// 设置组织类型下拉列表
		ddlOrgTypeObj = $("#organize-type-dropdownlist").dropDownList({
			inputName : "organizeTypeName",
			inputValName : "organizeType",
			buttonText : "",
			width : "117px",
			readOnly : false,
			required : true,
			maxHeight : 200,
			onSelect : function(i, data, icon) {
				createOrganizeDynamicTable(data);
			},
			items : orgTypeDdlItems
		});

		ddlOrgTypeObj.setData("请选择", "0", "");

		if (rowEditing > -1) {
			var row = tbOrgs.row(rowEditing);

			$("#id").val(row.id);
			$("#organizeName").val(row.organizeName);
			$("#organizeCode").val(row.organizeCode);
			$("#organizeType").val(row.organizeType);
			if (row.organizeType != 99) {
				$("#parentOrganizeName").val(row.parentOrganize.organizeName);
				$("#parentOrganizeId").val(row.parentOrganize.id);
			}
			// 设置组织类型
			ddlOrgTypeObj.setData(dropDownListOrgTypes.get(row.organizeType).name, row.organizeType, "");
			// 生成组织类型属性表格
			createOrganizeDynamicTable(row.organizeType);
		}
		$("#btn-select-org").on("click", function() {
			removeAllAlert();
			createModalWithIframe("select-org", 800, 550, "选择上级组织", "organizeSelect/tree");
			// $("#select-org-modal").modal("show");alert("Test");
		});
	});

	function receiveOrganizeInfo(orgObj) {
		$('#parentOrganizeName')[0].value = orgObj.organizeName;
		$('#parentOrganizeId')[0].value = orgObj.id;
		$("#select-org-modal").modal('hide');
	}

	function createOrganizeDynamicTable(organizeType) {
		var organizeId = $('#id').val();
		if (organizeId == undefined || organizeId == null || organizeId == "") {
			organizeId = 0;
		}
		var ownerType = "0";
		var filter = "0";
		var organizeId = $('#id').val();
		if (organizeId == undefined || organizeId == null || organizeId == "") {
			organizeId = 0;
		}
		if (organizeType != undefined) {
			if (organizeType == 3) {
				ownerType = "127";
			}
			if(organizeType == 1){
				ownerType = "127";
				filter = "1";
			}
			var jsonData = {
				"ownerType" : ownerType,
				"filter" : filter,
				"ownerId" : ""+organizeId
			};
			$.ajax({
				type : "post",
				url : "${ctx}/param/getParamValue",
				data : "params=" + JSON.stringify(jsonData),
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						var datas = data.RETURN_PARAM;
						if (datas) {
							dynamicTableObj = $("#org-form-table").dynamicTable({
								items : datas,
								method : "append",
								groupId : "organize_attribute_group_id"
							});
						} else {
							if (dynamicTableObj) {
								dynamicTableObj.destroy();
							}
						}
						return;
					} else {
						showDialogModal("error-div", "操作错误", data.MESSAGE);
						return false;
					}
				},
				error : function(req, error, errObj) {
					showDialogModal("error-div", "操作错误", "获取数据失败：" + errObj);
					return false;
				}
			});
		}
	}

	function showEditAlert(type, content, name, position) {
		showAlert(type, content, name, position);
		$("#" + name).focus();
	}

	function saveOrganize() {
		var ownerType = "0";
		var filter = "0";
		var orgData = getFormData("org-form-edit");

		var organizeName = orgData.organizeName;
		if (organizeName.length == 0) {
			showEditAlert('warning', '组织名称不能为空！', "organizeName", 'top');
			return;
		}
		var organizeCode = orgData.organizeCode;
		if (organizeCode.length == 0) {
			showEditAlert('warning', '组织编码不能为空！', "organizeCode", 'top');
			return;
		}
		var parentOrgName = orgData.parentOrganizeName;
		if (parentOrgName.length == 0) {
			showEditAlert('warning', '上级组织不能为空！', "parentOrganizeName", 'top');
			return;
		}
		var organizeType = orgData.organizeType;
		if (organizeType.length == 0 || organizeType == 0) {
			showEditAlert('warning', '组织类型不能为空！', "organizeType", 'top');
			return;
		}

		// 组织提交数据（按com.rib.sec.entity.SecOrganize实体类构造）
		var parentOrganizeName = orgData.parentOrganizeName;
		var parentOrganizeId = orgData.parentOrganizeId;
		delete orgData.parentOrganizeName;
		delete orgData.parentOrganizeId;
		if (parentOrganizeId.length != 0) {
			$(orgData).attr({
				"parentOrganize" : {
					"id" : parentOrganizeId,
					"organizeName" : parentOrganizeName
				}
			});
		}
		delete orgData.organizeTypeName;

		// 组织属性值处理：调整为com.rib.sec.entity.SecOrganizeAttribute格式，并合并至orgData
		var attrs = dynamicTableObj.getChangedItems();
		if (attrs.length > 0) {
			var attrArray = new Array();
			$.each(attrs, function(n, value) {
				var attribute;
				if (orgData.id == "") {
					attribute = {
						attributeId : value.attributeId,
						attributeValue : value.value
					};
				} else {
					attribute = {
						id : value.id,
						attributeId : value.attributeId,
						attributeValue : value.value,
						organize : {
							id : orgData.id
						}
					};
				}
				attrArray[attrArray.length] = attribute;
			});
			// 合并组织属性
			orgData = $.extend(orgData, {
				attributes : attrArray
			});
		}
		if (organizeType == 3) {
			ownerType = "127";
		}
		if(organizeType == 1){
			ownerType = "127";
			filter = "1";
		}
			$.ajax({
				type : "post",
				url : "${ctx}/organizeManage/create",
				data : JSON.stringify(orgData),
				dataType : "json",
				contentType : "application/json;charset=utf-8",
				success : function(data) {
					if (data && data.CODE && data.CODE == "SUCCESS") {
						var datas = data.RETURN_PARAM;
						saveParam(ownerType,filter,datas.orgId);
						loadGrid();
						$("#edit-org-modal").modal('hide');
						return;
					} else {
						showAlert('warning', data.MESSAGE, "edit-org-button-confirm", 'top');
						return;
					}
				},
				error : function(req, error, errObj) {
					showAlert('warning', '提交失败：' + errObj, "edit-org-button-confirm", 'top');
					return;
				}
			});
		
	}
	
	//保存参数
	function saveParam(ownerType,filter,ownerId){
		if(ownerType != "127"){
			return true;
		}
		var formData = dynamicTableObj.getFormData();
        $.ajax({
             type: "post",
             url: "${ctx}/param/saveParamValue?ownerType=" + ownerType + "&filter="+ filter + "&ownerId=" + ownerId,
             data:"params=" + JSON.stringify(formData),
             success: function(data) 
             {
                 if (data && data.CODE && data.CODE == "SUCCESS") {
                     return true;
                 } else {
                     showMsg(data.MESSAGE);
                     return false;
                 }
                 return true;
             },
             error: function(req,error,errObj) 
             {
                 showDialogModal("error-div","操作错误",errObj);
                 return;
             }
        });
	}
</script>