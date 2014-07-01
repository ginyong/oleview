<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Oleview</title>
<style>
#page {
	box-shadow: 0 0 0 5px blue inset;
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
		$('.oleview_tag').click(
				function(event) {
					event.stopPropagation();

					var parentEls = "";
					parentEls = $(this).parents().map(
							function() {
								var ret = serialize_dom_data(this.tagName,
										this.id, this.className);
								return ret;
							}).get().join(",");

					var parentEls_arry = parentEls.split(",");
					parentEls_arry.reverse();
					var parentEls_str = parentEls_arry.toString();
					parentEls_str += ",";
					parentEls_str += serialize_dom_data(this.tagName, this.id,
							this.className);

					select_dom($(this), parentEls_str);
				});
	}
	function serialize_dom_data(tag_name, tag_id, tag_class) {
		var ret_str = tag_name;

		//ID가 존재하면 추가
		if (tag_id != '') {
			ret_str += "#";
			ret_str += tag_id;
		}

		//Class에 Oleview 테그 제거
		tag_class = tag_class.replace(' oleview_tag', '');
		tag_class = tag_class.replace('oleview_tag', '');

		//Class가 존재할경우 추가
		if (tag_class != '') {
			var tag_class_arry = tag_class.split(" ");
			for ( var i in tag_class_arry) {
				if (isValidClass(tag_class_arry[i])) {
					ret_str += ".";
					ret_str += tag_class_arry[i];
				}
			}
		}

		return ret_str;
	}
	function isValidClass(str) {
		if (str == '')
			return false;
		if (str.indexOf("#") > -1)
			return false;
		return true;
	}
	function replaceAll(str, orgStr, repStr) {
		return str.split(orgStr).join(repStr);
	}

	function select_dom(element, dom_data) {
		var width = element.width();
		var height = element.height();
		var url = $("#input_url").val();

		var replace_url = "/Oleview/main.jsp?" + "width=" + width + "&height="
				+ height + "&url=" + encodeURIComponent(url) + "&dom_data="
				+ encodeURIComponent(dom_data);
		//main.jsp 페이지로 이동 + 파라미터 전달
		window.location = replace_url;
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