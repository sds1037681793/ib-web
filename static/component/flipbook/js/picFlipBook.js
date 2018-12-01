/**
 * 图片查看插件：flipBook，翻页效果
 * options:
 * width:翻页宽度；
 * height:翻页高度；
 * frontColor：备注字体颜色；
 * frontSize：备注字体尺寸
 * backGroundColor：背景颜色
 */
(function($){
	jQuery.fn.picFlipBook = function(divId,options) {
		var defaults = {
				width:$(window).width(),
				height:$(window).height(),
				frontColor:'#fff',
				frontSize:24,
				backGroundColor:'black'
			};
		var options = $.extend(defaults, options);
		var totalImages = 0;
		var photoFlipHtml = "";
		//屏蔽ios下上下弹性
		$(window).on('scroll.elasticity', function (e) {
		  e.preventDefault();
		}).on('touchmove.elasticity', function (e) {
		  e.preventDefault();
		});
		//打开图片浏览
		this.openPicFlip = function(titlesString,imageUrlsString) {
			setImages(titlesString,imageUrlsString,options.width,options.height);
			loadApp(options.width,options.height);
			setTimeout(function(){$(".flipbook-viewport").show();},1000);
		}
		
		function setImages(titlesString,imageUrlsString,maxWidth,maxHeight) {
			//清空div
			$("#"+divId).empty();
			photoFlipHtml = "";
			photoFlipHtml += '<div class="flipbook-viewport" style="display:none;">';
			photoFlipHtml += '<div class="container">';
			photoFlipHtml += '<div class="flipbook">';
			// 动态生成html
			var srcTitles = titlesString.split(",");
			var srcImageUrls = imageUrlsString.split(",");
			var titles = new Array();
			var imageUrls = new Array();
			if("" != imageUrlsString && srcImageUrls.length>0) {
				for(var j=0;j<srcImageUrls.length;j++){
					if(null!=srcImageUrls[j] && "" != srcImageUrls[j]) {
						imageUrls.push(srcImageUrls[j]);
						if(j<srcTitles.length){
							titles.push(srcTitles[j]);
						}
					}
				}
			}
			var index = 1;
			var total =imageUrls.length;
			totalImages = total;
			if("" != imageUrlsString && imageUrls.length>0) {
				for(var i = 0;i < total; i++) {
					var indexStr = "("+index+"/"+total+")";
					photoFlipHtml += '<div style="background-color:'+options.backGroundColor+';display:table-cell;text-align:center;vertical-align:middle;">';				
					photoFlipHtml += '<img src="'+imageUrls[i]+'" style="max-width:'+maxWidth+'px;max-height:'+maxHeight+'px;" alt="">';
					photoFlipHtml += '<div class="fanye" style="color:'+options.frontColor+';font-size:'+options.frontSize+'px"><span>'+titles[i]+indexStr+'</span></div>';
					photoFlipHtml += '</div>';
					index++;
				}    
			}else{
				showDialogModal("error-div", "未找到图片", "未找到图片");
			}
			photoFlipHtml += '</div>';
			photoFlipHtml += '</div>';
			photoFlipHtml += '</div>';
			$("#"+divId).html(photoFlipHtml);
		}
		
		function loadApp(width,height) {
			  var w=$(window).width();
			  var h=$(window).height();
			  $('.flipboox').width(w).height(h);
			  $(window).resize(function(){
				  w=$(window).width();
				  h=$(window).height();
				  $('.flipboox').width(w).height(h);
			  });

			  $('.flipbook').turn({
					  // Width
					  width:width,
					  // Height
					  height:height,
					  // Elevation
					  elevation: 50,
					  display :'single',
					  // Enable gradients
					  gradients: true,
					  // Auto center this flipbook
					  autoCenter: true
			  });
			}
		
		return this.each(function() {
			
		});
		
	}
})(jQuery);