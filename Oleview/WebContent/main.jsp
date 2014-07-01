<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	//String url = (String) request.getAttribute("url");
	//String dom_data = (String) request.getAttribute("dom_data");
	//String sWidth = (String) request.getAttribute("width");
	//String sHeight = (String) request.getAttribute("height");
	//int width = 0;
	//int height = 0;
	//if (sWidth != null)
	//	width = Integer.parseInt(sWidth);
	//if (sHeight != null)
	//	height = Integer.parseInt(sHeight);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
	.content{
		overflow: hidden;
	}
</style>
<script src="scripts/jquery-1.11.0.min.js"></script>
<script>
	$(document).ready(
			function() {
				var width = getQueryVariable("width");
				var height = getQueryVariable("height");
				var url = getQueryVariable("url");
				var dom_data = getQueryVariable("dom_data");
				console.log(dom_data);
				var content1 = $('<iframe></iframe>');
				content1.width(width);
				content1.height(height);
				content1.attr('src', '/Oleview/get_page_part.do?url='
						+ encodeURIComponent(url) + '&dom_data='
						+ encodeURIComponent(dom_data));
				content1.attr('scrolling','no');
				content1.addClass('content');
				content1.appendTo($('body'));
				
				// on iframe loaded
				content1.on('load', function(e) {
					var cont = content1.contents();
					$('body').append(cont);
				});

			});

	function getQueryVariable(variable) {
		var query = window.location.search.substring(1);
		var vars = query.split('&');
		for (var i = 0; i < vars.length; i++) {
			var pair = vars[i].split('=');
			if (decodeURIComponent(pair[0]) == variable) {
				return decodeURIComponent(pair[1]);
			}
		}
		console.log('Query variable %s not found', variable);
	}
</script>
</head>
<body>

</body>
</html>