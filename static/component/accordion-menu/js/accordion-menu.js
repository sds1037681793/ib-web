/**
 * Accordion Menu
 * @description: 抽屉式菜单组件，支持两级菜单
 * @autor: kefei
 * @version: 1.0
 * @params:
 *          items  菜单数据，json数组
 *                 样例：[{id: 1, name: "系统管理", icon: "iconic new-window", childCount: 1, children: [{id: 2, name: "组织管理", icon: "iconic pencil", url: "/organizeManager"}]}]
 *                 id: 菜单id
 *                 name: 菜单名称
 *                 icon: 菜单图标样式
 *                 childCount: 子菜单个数
 *                 children: 子菜单数组
 *          url    菜单数据请求url，有此项时，以请求的数据为准
 *          goPage 菜单链接处理方法，参数包含id（菜单ID）、name（菜单名称）、icon（菜单图标）、url（菜单URL）
 */
(function($) {
	jQuery.fn.accordion = function(options) {
		// 默认参数
		var defaults = {

		};

		this.init = function() {
			$('.submenu > a').click(function(e) {
				e.preventDefault();
				var submenu = $(this).siblings('ul');
				var li = $(this).parents('li');
				var submenus = $('.accordion-sidebar li.submenu ul');
				var submenus_parents = $('.accordion-sidebar li.submenu');
				if (li.hasClass('open')) {
					if (($(window).width() > 768) || ($(window).width() < 479)) {
						submenu.slideUp();
					} else {
						submenu.fadeOut(250);
					}
					li.removeClass('open');
				} else {
					if (($(window).width() > 768) || ($(window).width() < 479)) {
						submenus.slideUp();
						submenu.slideDown();
					} else {
						submenus.fadeOut(250);
						submenu.fadeIn(250);
					}
					submenus_parents.removeClass('open');
					li.addClass('open');
				}
			});

			$('.accordion-sidebar > a').click(function(e) {
				e.preventDefault();
				var sidebar = $('.accordion-sidebar');
				var ul = $('.accordion-sidebar > ul');
				if (sidebar.hasClass('open')) {
					sidebar.removeClass('open');
					ul.slideUp(250);
				} else {
					sidebar.addClass('open');
					ul.slideDown(250);
				}
			});
		};

		var options = $.extend(defaults, options);
		return this.each(function() {
			var opts = options;
			var obj = $(this);
			var urlItems = new Array();

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
			var html = '<div id="' + accordionId + '" class="accordion-sidebar">';
			html += '<ul>';
			if (datas != undefined) {
				$.each(jQuery.parseJSON(datas), function(n, value) {
					if (value.childCount > 0) {
						html += '<li class="submenu">';
						html += '<a href="#">';
						html += '<span class="icon ' + value.icon + '" style="margin-right: 15px;"></span>';
						html += '<span>' + value.name + '</span>';
						html += '<span class="glyphicon expand" style="float: right; margin-right: 10px; margin-top: 5px;"></span>';
						html += '</a>';
						html += '<ul>';

						$.each(value.children, function(m, child) {
							html += '<li id="accordion-item-' + child.id + '">';
							html += '<a href="#">';
							html += '<span class="icon ' + child.icon + '" style="margin-right: 10px;"></span>';
							html += '<span>' + child.name + '</span>';
							html += '</a>';
							html += '</li>';
							urlItems[urlItems.length] = child;
						});

						html += '</ul>';
						html += '</li>';
					} else {
						html += '<li id="accordion-item-' + value.id + '">';
						html += '<a href="#">';
						html += '<span class="icon ' + value.icon + '" style="margin-right: 10px;"></span>';
						html += '<span>' + value.name + '</span>';
						html += '</a>';
						html += '</li>';
						urlItems[urlItems.length] = value;
					}
				});
			}
			html += '</ul>';
			html += '</div>';

			obj.html(html);

			// 设置事件监听
			$.each(urlItems, function(n, value) {
				$("#accordion-item-" + value.id).click(function(e) {
					e.preventDefault();
					$(".accordion-sidebar .active").removeClass("active");
					$("#accordion-item-" + value.id).addClass("active");
					if (opts.goPage) {
						opts.goPage(value.id, value.name, value.icon, value.url);
					}
				});
			});
		});
	}
})(jQuery);