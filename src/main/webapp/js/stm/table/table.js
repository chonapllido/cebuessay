doCheckAll = function(o) {
	var obj = $(o).closest('form').find('input:checkbox');

	if (o.checked) {
		obj.attr('checked', 'checked');
	} else {
		obj.removeAttr('checked');
	}
};

bCheckAll = function(o) {
	if ((
		$(typeof o === 'object' ? o : '#' + o)
		.closest($('form'))
		.find('input:checkbox:checked').length -
		(typeof 
			$(typeof o === 'object' ? o : '#' + o)
			.closest($('form'))
			.find('.checkall')
			.attr('checked') !== 'undefined' ? 1 : 0)
	) <= 0) {
		alert(language == 'ko' ? '선택된 데이터가 없습니다' : 'Nothing Checked Item');
		return false;
	}
	return true;
};