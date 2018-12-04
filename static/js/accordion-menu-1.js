/**
 * Accordion Menu
 * @description: 手风琴式菜单组件，支持三级菜单
 * @autor: xiejun
 * @version: 1.0
 * @params:
 *          items  菜单数据，json数组
 *                 样例：[{id: 1, name: "首页", icon: "/static/icon/index/zuzhiguanli.svg", childCount: 1,code："SY", children: [{id: 2, name: "消防系统", icon: "/static/icon/index/zuzhiguanli.svg", code："XFXT", children: [{id: 3, name: "消防水系统", icon: "", code："XFSXT",url: "/organizeManager"}]}]}]
 *                 id: 菜单id
 *                 name: 菜单名称
 *                 icon: 菜单图片url
 *                 code:菜单CODE
 *                 childCount: 子菜单个数
 *                 children: 子菜单数组
 *          url    菜单数据请求url，有此项时，以请求的数据为准
 *          goPage 菜单链接处理方法，参数包含id（菜单ID）、name（菜单名称）、icon（菜单图标）、url（菜单URL）
 */

(function($) {
	jQuery.fn.accordion1 = function(options) {
		var imgUrlT ='';
		var isChoosed = false;
		var chooseItem;
		var green = 'rgba(255,255,255,0.1)';
		var green_a  = '#108A7E';
		//var mainMenuColor = "#262D36";//西子国际样式
		var mainMenuColor = ["#262D36","#162D39"];//华数样式
		//var contentBgColor = "#404D5A";//西子国际首页背景
		var contentBgColor = ["#404D5A","#09232F"];//华数首页背景
		var backs=new Array(green,green_a);
		// 默认参数
		var defaults = {

		};

		this.init = function() {};

		var options = $.extend(defaults, options);
		return this.each(function() {
			var opts = options;
			var obj = $(this);
			var urlItems = new Array();
			var firstItems = new Array();

			var datas = opts.items;
			if (opts.url != undefined && opts.url.length > 0) {
				$.ajax({
					type : "post",
					async : false,
					url : opts.url,
					contentType : "application/json;charset=utf-8",
					success : function(data) {
						datas = data;
					},
					error : function(req, error, errObj) {

					}
				});
			}

			var accordionId = obj.context.id + "-accordion";
			var htmlLevel_left = '<div id="' + accordionId + '" class="accordion-1-sidebar">';//左边菜单
			var htmlLevel_top='';//顶部菜单
			htmlLevel_left += '<ul>';
			if (datas != undefined) {
				$.each(jQuery.parseJSON(datas), function(n, value) {//一级菜单
					var firstImgUrl = value.icon;
					if(typeof(firstImgUrl)!= 'undefined'&&firstImgUrl != '' && firstImgUrl.length>3){
						firstImgUrl = ctx+firstImgUrl.substring(3);
					}else{
						firstImgUrl='';
					}
					htmlLevel_left += '<li class="submenu submenu-top"  id="accordion-item-' + value.id + '"  data-url="'+value.url+'" >';
					htmlLevel_left += '<div style="color: #8E9EBD;cursor:pointer;line-height: 40px;font-size: 16px;">';
					if(firstImgUrl != ''){
						htmlLevel_left += '<div style="display: inline-block;margin-left: 20px"><img src="'+firstImgUrl+'" /></div>';
					}else{
						htmlLevel_left += '<div style="display: inline-block;margin-left: 20px"><span class="icon glyphicon glyphicon-home" style="margin-right: 20px;"></span></div>';
					}
					htmlLevel_left += '<div style="display: inline-block;margin: 10px;"><span style="vertical-align: middle;font-size: 14px">' + value.name + '</span></div>';

                    if (value.childCount > 0) {//存在二级菜单

                        htmlLevel_left += '<div class="icon-arrow-right"></div>';

                        $.each(value.children, function(m, child) {//二级菜单
                           /* var secondImgUrl = child.icon;
                            if(typeof(secondImgUrl)!= 'undefined'&&secondImgUrl != '' && secondImgUrl.length>3){
                                secondImgUrl = ctx+secondImgUrl.substring(3);
                            }else{
                                secondImgUrl='';
                            }*/
                            htmlLevel_left += '<ul class="children-submenu-ul">' +
								'<li class="submenu children-submenu"  id="accordion-item-' + child.id + '"  data-url="'+child.url+'">' ;
                            htmlLevel_left += '<div style="color: #8E9EBD;cursor:pointer;line-height: 40px;font-size: 16px;">';
                            htmlLevel_left += '<div style="display: inline-block;margin:11px 0 11px 60px;"><span style="vertical-align: middle;font-size: 14px;">' + child.name + '</span></div>';


                            if (child.childCount > 0) {//存在三级菜单
                                htmlLevel_left += '<div class="icon-arrow-right"></div>';
/*
                                htmlLevel_top += '<ul class="navbar-nav" style="display:none" name="accordion-name-'+value.id+'">';
                                htmlLevel_top += '<li class="dropdown" >';
                                htmlLevel_top += '<a href="#" class="dropdown-toggle" data-toggle="dropdown">';
                                htmlLevel_top += '<div class="menu_item">';
                                //htmlLevel_top += '<div style="width: 100%; height: 0.5rem; background:'+backs[m%9]+';"></div>';
                                htmlLevel_top += '<table><tr class="first_one"><td align="center">';
                                if(secondImgUrl != ''){
                                    htmlLevel_top += '<img src="'+secondImgUrl+'" />';
                                }
                                htmlLevel_top += '</td></tr><tr class="second"><td  align="center">'+child.name +'</td></tr>';
                                htmlLevel_top += '</table></div></a>';
                                htmlLevel_top += '<ul class="dropdown-menu" style="min-width: 10rem;padding:0;margin-left:-1px;margin-top:-1px;border-radius: 0;">';*/        htmlLevel_left += '<ul class="three-parent three-parent-ul' + child.id + '">'
                                $.each(child.children, function(k, three) {//三级菜单
                                    /*htmlLevel_top += '<li class="three" style="margin-bottom: -1.5px;" id="accordion-item-' + three.id +'"><a style="color: #DDDDDD; opacity: 0.8;font-size: 14px;line-height: 22px;text-align:center;padding:0;padding-top:9px;" href="#">'+three.name+'</a></li>';
                                    urlItems[urlItems.length] = three;
                                    if(typeof(three.code)!='undefined' && three.code!=''){
                                        menuMap.put(three.code,three)
                                    }*/

                                    htmlLevel_left +=   '<li class="submenu children-submenu-three"  id="accordion-item-' + three.id + '" data-url="'+three.url+'" >' ;
                                    htmlLevel_left += '<div style="color: #8E9EBD;cursor:pointer;line-height: 40px;font-size: 16px;">';
                                    htmlLevel_left += '<div style="display: inline-block;margin:11px 0 11px 100px;"><span style="vertical-align: middle;font-size: 14px;">' + three.name + '</span></div></div></li>';

                                });
                                htmlLevel_left += '</ul>'
                              /*  htmlLevel_top += '</ul></li></ul>';*/
                            }/*else{
                                htmlLevel_top += '<ul class="navbar-nav" style="display:none" name="accordion-name-'+value.id+'" >';
                                htmlLevel_top += '<div class="menu_item" id="accordion-item-' + child.id + '">'
                                //htmlLevel_top += '<div style="width: 100%; height: 0.5rem; background:'+backs[m%9]+';"></div>';
                                htmlLevel_top += '<table><tr class="first_one"><td align="center">';
                                if(secondImgUrl != ''){
                                    htmlLevel_top += '<img src="'+secondImgUrl+'" />';
                                }
                                htmlLevel_top += '</td></tr><tr class="second"><td  align="center">'+child.name +'</td></tr>';
                                htmlLevel_top += '</table></div></ul>';
                                urlItems[urlItems.length] = child;
                                if(typeof(child.code)!='undefined' && child.code!=''){
                                    menuMap.put(child.code,child)
                                }
                            }*/
                            htmlLevel_left +='</li></ul>';
                        });
                    } /*else {
                        urlItems[urlItems.length] = value;
                        if(typeof(value.code)!='undefined' && value.code!=''){
                            menuMap.put(value.code,value)
                        }
                    }*/

					htmlLevel_left += '</div>';
					htmlLevel_left += '</li>';


					firstItems[firstItems.length] = value;
				});
			}
			htmlLevel_left += '</ul>';
			htmlLevel_left += '</div>';
			obj.html(htmlLevel_left);
			$("#project_menu_head").html(htmlLevel_top);
			var ulName = $("#project_menu_head ul").first().attr("name");
			$("[name ="+ulName+"]").css('display','block');

			/*$.each(firstItems, function(n, value){
				$("#accordion-item-" + value.id).click(function(e) {
					$(".menu_item").css("background",mainMenuColor[1]);
					isChoosed = false;
					$(".navbar-nav").css('display','none');
					var accName = "[name = accordion-name-"+value.id+"]";
					$(accName).css('display','block');
					//点击一级菜单跳转页面
					if (opts.goPage) {
						if(value.code=='PROJECT_PAGE'){//跳转项目首页
							try {
					    		if(typeof(eval("unloadAndRelease")) == "function") {
					                unloadAndRelease();
					            }
					        } catch(e) {}
					        var organizeId = $("#login-org").data("orgId");
					        var homeUrl = getHomepage(organizeId);
							$("#content-page").load(getAppName() + homeUrl);
				          /!*  $("#content").css("background",contentBgColor[1]);*!/
				            $("#content-header").hide();
				            $("#breadcrumb").hide();
				            $("#container-fluid").css("padding-left","0px");
				            $("#container-fluid").css("padding-right","0px");
						}else{
							var name = value.name;
							if(value.children!=null && value.children.length>0){
								if(value.children[0].children!=null &&  value.children[0].children>0){
									name = value.children[0].children[0].name;
								}else{
									name = value.children[0].name;
								}
							}
							opts.goPage(value.id, name, value.icon, value.url);
						}
					}
				});

			});
			$(".menu_item").hover(function() {
				if(isChoosed){
					$(".menu_item").css("background",mainMenuColor[1]);
					$(".menu_item").css("opacity","0.8");
					$(this).css("background",green_a);
					$(this).css("opacity","1");
					chooseItem.css("background",green);
					chooseItem.css("opacity","1");
				}else{
					$(".menu_item").css("background",mainMenuColor[1]);
					$(".menu_item").css("opacity","0.8");
					$(this).css("background",green);
					$(this).css("opacity","1");
				}
				//$(this).parent().dropdown('toggle');//鼠标移动到菜单显示下拉框
				var isExpand =$(this).parent().parent().hasClass('open');
				var isUl=$(this).parent().is('ul');
				if(!isExpand){
					$(this).parent().click();
				}
			},function(){
				var isUl=$(this).parent().is('ul');
				if(!isUl){
					$(this).parent().click();
					$(".menu_item").css("background",mainMenuColor[1]);
					$(".menu_item").css("opacity","0.8");
				}else{
					$(this).css("background",mainMenuColor[1]);
					$(this).css("opacity","0.8");
				}
				if(isChoosed){
					chooseItem.css("background",green);
					chooseItem.css("opacity","1");
				}
			});

			$(".dropdown-menu").hover(function() {
				$(this).parent().children().first().children().first().css("background",green);
				$(this).parent().children().first().children().first().css("opacity","1");
				$(this).parent().children().first().click();
				if(isChoosed){
					$(this).parent().children().first().children().first().css("background",green_a);
					chooseItem.css("background",green);
					chooseItem.css("opacity","1");
				}else{
					$(this).parent().children().first().children().first().css("background",green);
					$(this).parent().children().first().children().first().css("opacity","1");
				}
			},function(){
				$(this).parent().click();
				$(".menu_item").css("background",mainMenuColor[1]);
				$(".menu_item").css("opacity","0.8");
				if(isChoosed){
					chooseItem.css("background",green);
					chooseItem.css("opacity","1");
				}
			});*/

			$(".submenu-top").click(function(e) {
				e.stopPropagation();
                if($(this).hasClass("open")){
                    $(this).removeClass("open");
                }else{
                    $(".submenu-top").removeClass("active").removeClass("open");
                    $(this).addClass("open");
                    if(!$(this).find(".children-submenu").length){
                        $(this).addClass("active");
                        opts.goPage("", "", "",  $(this).data("url"));
                    }
                }
			});
			$(".children-submenu").click(function(e) {
                e.stopPropagation();
              if($(this).hasClass("open")){
                  $(this).removeClass("active").removeClass("open");
			  }else{
                  $(".children-submenu").removeClass("active").removeClass("open");
                  $(this).addClass("open");
                  if(!$(this).find(".children-submenu-three").length){
                      $(this).addClass("active");
                      opts.goPage("", "", "",  $(this).data("url"));
                  }
			  }
            });
			$(".children-submenu-three").click(function(e) {
                e.stopPropagation();
                $(".children-submenu-three").removeClass("active");
                $(this).addClass("active");
                opts.goPage("", "", "",  $(this).data("url"));
            });
			// 设置事件监听
			/*$.each(urlItems, function(n, value) {
				$("#accordion-item-" + value.id).click(function(e) {
					e.preventDefault();
					//$(".accordion-sidebar .active").removeClass("active");
					//$("#accordion-item-" + value.id).addClass("active");
					if (opts.goPage) {
						var isUl=$(this).parent().is('.dropdown-menu');
						if(isUl){
							chooseItem=$(this).parent().parent().children().first().children();
						}else{
							chooseItem=$(this);
						}
						opts.goPage(value.id, value.name, value.icon, value.url);
						isChoosed=true;
						$(".menu_item").css("background",mainMenuColor[1]);
						$(".menu_item").css("opacity","0.8");
						chooseItem.css("background",green);
						chooseItem.css("opacity","1");
					}
				});
			});*/


			/*$(".submenu-top:first").addClass("open");*/
		});
	}
})(jQuery);