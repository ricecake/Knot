;(function($){
'use strict';

var defaults = {
	editorOptions: {}
};

$.fn.knotGroupEdit = function (options) {
	options = $.extend({}, defaults, options);
	return $(this).each(function() {
		var editor = CodeMirror(this, options.editorOptions);
	});
};

}(jQuery));
