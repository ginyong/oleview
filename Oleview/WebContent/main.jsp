<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	String url = (String) request.getAttribute("url");
	String dom_data = (String) request.getAttribute("dom_data");
	String sWidth = (String) request.getAttribute("width");
	String sHeight = (String) request.getAttribute("height");
	int width = 800;
	int height = 900;
	if (sWidth != null)
		width = Integer.parseInt(sWidth);
	if (sHeight != null)
		height = Integer.parseInt(sHeight);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="scripts/jquery-1.11.0.min.js"></script>
<script>
	$(document).ready(function() {
		var content1 = $('<iframe></iframe>');
		content1.width(<%= width %>);
		content1.height(<%= height %>);
		content1.attr('src', '/Oleview/get_page_part.do?url=www.naver.com');
		content1.appendTo($('body'));

		// on iframe loaded
		content1.on('load', function(e) {
			var cont = content1.contents();
			$('body').append(cont);
		});
		
	});
</script>
</head>
<body>

</body>
</html>