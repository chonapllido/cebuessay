fnJstree = function(id, url, sep, lang, callback) {

	if ($.jstree.reference('#' + id) != null) {
		$.jstree.reference('#' + id).destroy();
	}
	
	if (typeof sep === 'undefined') {
		sep = '';
	}
	
	$('#' + id).jstree({
		'core' : {
			'check_callback' : function(o, n, p, i, m) {
				// 최상위와 같은 계층으로 이동되는것을 막는다
				if(m && m.dnd && m.pos === 'b' && m.ref.parent === '#') { return false; }
				if(m && m.dnd && m.pos === 'a' && m.ref.parent === '#') { return false; }
				return true;
			},
			'data' : {
				'url' : function (node) {
				  return url;
				}
			}
		}
		, 'contextmenu' : {
			'items' : function(node) {
				var tmp = $.jstree.defaults.contextmenu.items();
				delete tmp.ccp.submenu;
				tmp.ccp.label = "메뉴 배포 관리";
				tmp.create.label = "하위 메뉴 등록";
				tmp.rename.label = "메뉴명 변경";
				tmp.remove.label = "메뉴 삭제";
				
				if (node.parent === '#') {
					tmp.ccp._disabled = true;
					tmp.rename._disabled = true;
					tmp.remove._disabled = true;
					delete tmp.ccp.action;
					delete tmp.rename.action;
					delete tmp.remove.action;
					return tmp;
				}
				
				tmp.ccp.action = function() { callback(node); };
				return tmp;
			}
		}
		, "plugins" : [ "contextmenu", "dnd", "state" ]
	}).bind('select_node.jstree', function(e, data) {
		log('');
	}).bind('create_node.jstree', function(e, data) {
		var _id = (lang == '' ? 'K' : lang.toUpperCase().substring(0, 1)) + sep + date.format('yyyyMMddhhmmssms');
		data.instance.set_id(data.node, _id);
		log('');
	}).bind('rename_node.jstree', function(e, data) {
		log('');
	}).bind('delete_node.jstree', function(e, data) {
		if (data.parent === '#')
		{
			alert('최상위값이 변경되었으므로 다시 불러옵니다');
			data.instance.refresh();
			return;
		}
		log('');
	}).bind('move_node.jstree', function(e, data) {
		log('');
	}).bind('show_contextmenu.jstree', function(e, data) {
		log('');
	}).bind('ready.jstree', function(e, data) {
		$(data.instance.element.context.firstChild.firstChild).addClass('root');
		//$('.jstree-leaf').addClass('jstree-file');
		log('');
	});
};

fnJstreeGetJSON = function(id) {
	return JSON.stringify($.jstree.reference('#' + id).get_json());
};

fnJstreeReset = function(id) {
	$('#' + id).jstree('refresh');
};

fnJstreeSelect = function(id, url, callback) {

	$('#' + id).jstree({
		'core' : {
			'data' : {
				'url' : function (node) {
				  return url;
				}
			},
			'expand_selected_onload' : false
		}
	}).bind('select_node.jstree', function(e, data) {
		if (data.node.parent === '#') {
			return;
		}
		log(data);
		callback(data.node);
	}).bind('init.jstree', function(e, data) {
		// 최초 모두 닫고 DESELECT
		data.instance.deselect_all();
		data.instance.close_all();
	});
};

fnGetRoute = function(id, nodeid, route, depth) {
	var node = $.jstree.reference('#' + id).get_node(nodeid);
	if (nodeid !== '#') {
		log(node);
		route = fnGetRoute(id, node.parents[0], '', depth + 1) + ' >> ' + node.text;
	};
	log('depth : ' + depth);
	if (depth === 0) {
		route = route.substring(4, route.length);
	}
	return route;
};