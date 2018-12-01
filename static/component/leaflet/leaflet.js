var areaPlan = {
	initMap : function(map) {
		map.setImage(area_plan);

		map.bind("Save:enable", function($map, layer) {
			// 是否需要进行交叉判断
			if (map.options.preventAcross === true) {
				// 读取出所有的原来的层
				var layers = map.drawnItems.getLayers()
				var layer_point = L.CustomUtils.Polygon2PointList(layer)
				// 当前层
				// 遍历进行判断
				for ( var i in layers) {
					var l = L.CustomUtils.Polygon2PointList(layers[i])
					if (L.CustomUtils.DetectPolygonsAcross(l, layer_point)) {
						alert("绘制区域有交叉")
						return false;
					}
				}
			};
			return true;
		})

		map.bind("Delete:after", function($map, layer) {
			var layer_data = layer.getData();
			$.each(area_children, function(index, item) {
				if (item.id == layer_data.id) {
					item.hasSet = false;
					areaPlan.areaListPanel.addNosetArea(item);
				};
			})

			getDeleteLayler(layer);
		})

		map.bind('Save:before', function($map, layer) {
			// 创建出弹窗
			// debugger;
			receiveLayer(layer);
		});

	},

	initAreaList : function() {

	},

	initPloygons : function(map, layers) {
		map.drawnItems.clearLayers()
		$.each(layers, function(index, item) {
			// try{
			if (!item.location) {
				return;
			};
			var p = $.map(item.location.split('|'), function(value) {
				var o = value.split(",")
				return [
					[
							parseInt(o[1]), parseInt(o[0])
					]
				]
			});
			map.addPolygon(p, item.name, {
				id : item.id
			})
			item.hasSet = true;
			areaPlan.areaListPanel.addHassetArea(item);

			// }catch(e){
			// console.error(e.toString())
			// console.error("Polygon draw Error : "+item.Id+"->"+item.location)
			// }

		})
	},

	areaListPanel : {
		init : function(map) {
			$("#areas-noset-list").html("")
			$("#areas-hasset-list").html("")

			for ( var i in area_children) {
				if (area_children[i].hasSet) {
					this.addHassetArea(area_children[i])
				} else {
					this.addNosetArea(area_children[i])
				}
			}

		},

		addHassetArea : function(obj) {
			$("#areas-noset-list").find("a.btn[area-id=" + obj.id + "]").remove()
			$("#areas-hasset-list").append('<a href="javascript:" area-id="' + obj.id + '" class="area-label btn btn-sm btn-success">' + obj.name + '</a>')
		},

		addNosetArea : function(obj) {
			$("#areas-hasset-list").find("a.btn[area-id=" + obj.id + "]").remove()
			$("#areas-noset-list").append('<a href="javascript:" area-id="' + obj.id + '" class="area-label btn btn-sm btn-primary">' + obj.name + '</a>')
		}
	}
}

var area_plan;
var area_children;
var map;
/**
 * 图层初始化
 * @param imgPath 底部图片地址
 * @param obj 框定的区域位置和文字说明
 * @returns
 */
function initLeaflet(imgPath, obj, callbackFunc) {
	area_plan = imgPath;
	area_children = obj;
	map = $.ImageMap('map', {
		k : false
	});
	areaPlan.initMap(map);
	areaPlan.initPloygons(map, area_children);

	if(typeof(callbackFunc) == "function") {
		callbackFunc();
	}

}

function clearLeaflet() {
	map.drawnItems.clearLayers()
}

/**
 * 文字说明添加
 * @param layer 区域信息
 * @param text 展示文字
 * @param id
 */
function drawText(layer, text, id) {
	layer.setText(text);
	layer.setData({
		id : id
	});
	if (layer instanceof L.Rectangle) {
		map.triggerDraw("rectangle")
	} else {
		map.triggerDraw("polygon")
	}
}

function removeLayer(layer){
     map.drawnItems.removeLayer(layer);
}

function getAll(){
	return  map.getPolygonArrayList();
}


function uploadImageSuccess(image){
    map.setImage(image);
}
