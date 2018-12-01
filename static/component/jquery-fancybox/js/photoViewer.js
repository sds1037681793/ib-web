/**
 * 图片查看插件：基于fancybox实现
 * options:
 * fancyboxOpt表示全屏查看时候一些参数：
 * padding：浏览框内边距，和css中的padding一个意思
 * margin：浏览框外边距，和css中的margin一个意思
 * prevEffect：改变上一个图片的效果（'elastic', 'fade' or 'none'）
 * nextEffect：改变下一个图片的效果（'elastic', 'fade' or 'none'）
 * closeBtn：关闭按钮
 * arrows：翻页箭头
 * nextClick：点击图片左右来切换图片
 * tpl.error:图片未找到情况下显示
 */
(function($){
	jQuery.fn.photoViewer = function(divId,options) {
		var defaults = {
				fancyboxOpt:{
					  padding:0,
					  margin:5,
				      prevEffect : 'fade',
				      nextEffect : 'fade',
				      closeBtn  : false,
				      arrows    : true,
				      nextClick : true,
				      tpl: {
							error : '<p class="fancybox-error">图片未找到，请稍后重试</p>'
				      }
				}
			};
		var options = $.extend(defaults, options);
		var totalImages = 0;
		var photoViewerHtml = "";
		//打开图片浏览
		this.openViewer = function(titlesString,imageUrlsString) {
			setImages(titlesString,imageUrlsString);
			$.fancybox.open($('.fancy'),options.fancyboxOpt);
			
		}
		
		this.jumpTo = function(pageIndex){
			if($.fancybox.isOpen){
				jumpToImage(pageIndex);
			}
		}

		function jumpToImage(pageIndex) {
			if (null != pageIndex && undefined != pageIndex
					&& pageIndex <= totalImages) {
				$.fancybox.jumpto(pageIndex - 1);
			}
		}
		
		function setImages(titlesString,imageUrlsString) {
			//清空div
			$("#"+divId).empty();
			photoViewerHtml = "";
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
					photoViewerHtml += '<a id="photoViewer_pic_'+index+'" class="fancy" href="'+imageUrls[i]+'" data-fancybox-group="gallery" style="display:none;" title="'+titles[i]+indexStr+'"></a>';
					index++;
				}    
			}else{
				showDialogModal("error-div", "未找到图片", "未找到图片");
			}
			$("#"+divId).html(photoViewerHtml);
		}
		
		return this.each(function() {
			
		});
		
	}
})(jQuery);