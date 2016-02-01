;define([
	'jquery',
	'KnotConn',
	'component/chat',
	'component/groupedit',
	'component/session',
	'component/videochat'
], function($, KnotConn){
'use strict';

$(document).ready(function(){
        var connection = new KnotConn({
		url: '/ws/',
		onOpen: function() {
			connection.send('knot.session.join', { channel: $('#knot-channel-name').val() });
			$('#knot-chat').knotChat({
				connection: connection
			});
			$('#knot-edit').knotGroupEdit({
				connection: connection
			});
			$('#knot-video').knotVideoChat({
				connection: connection
			});
			//$('#knot-board').knotWhiteBoard({});
			$('#knot-session').knotSession({
				connection: connection
			});
		}
	});
});

});
