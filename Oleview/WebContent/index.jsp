<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Oleview</title>
<style>
#page {
	border: solid;
	border-color: red;
}
</style>
<script src="scripts/jquery-1.11.0.min.js"></script>
<script>
	var getPage = function() {
		var url = $("#input_url").val();
		var params = "url=" + url;
		$.ajax({
			url : "get_page.do",
			data : params
		}).done(function(data) {
			$('#page').empty();
			$('#page').append(data);
			$('#page').find("*").addClass('oleview_tag');
			add_event();
		}).fail(function() {
			alert('Fail');
		});
		return false;
	}
</script>
<script>
	function add_event() {
		// ele.addEventListener('hover', callback, false)
		$('.oleview_tag').mouseenter(function(event) {
			event.stopPropagation();
			$('#page').find("*").css('box-shadow', 'none');
			$('#page').find("*").css('background-color', 'none');
			$(this).css('box-shadow', '0 0 0 5px blue inset');
			$(this).css('background-color', 'rgba(0, 0, 0, 0.3)');
		});
		$('.oleview_tag').click(function(event) {
			event.stopPropagation();
			var parentEls = $(this).parents().map(function() {
				var ret = this.tagName;
				if (this.id != "") {
					ret = ret + "#" + this.id;
				}
				var pCName = this.className;
				pCName = pCName.replace(' oleview_tag', '');
				pCName = pCName.replace('oleview_tag', '');
				if (pCName != '') {
					ret = ret + "." + pCName;
				}
				return ret;
			}).get().join(",");

			var tmp = this.tagName;
			if (this.id != "")
				tmp = tmp + "#" + this.id;

			var myCName = this.className;
			myCName = myCName.replace(' oleview_tag', '');
			myCName = myCName.replace('oleview_tag', '');

			if (myCName != '') {
				tmp = tmp + "." + myCName;
			}
			parentEls = tmp + "," + parentEls;

			select_dom($(this), parentEls);
		});
	}
	function select_dom(element, dom_data) {
		alert("width = " + element.width() + ", height = " + element.height()
				+ ", dom = " + dom_data);
	}
</script>
</head>
<body>
	<div id="page"></div>
	<form onsubmit="getPage(); return false;">
		<table>
			<tr>
				<td>URL 입력 :</td>
				<td><input type="text" id="input_url" name="input_url" /></td>
				<td><input type="submit" /></td>
			</tr>
		</table>
	</form>
</body>
</html>