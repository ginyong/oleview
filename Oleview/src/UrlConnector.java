import java.io.IOException;
import java.util.Iterator;

import javax.net.ssl.ExtendedSSLSession;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * Servlet implementation class UrlConnector
 */
@WebServlet("/get_page.do")
public class UrlConnector extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UrlConnector() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String url = request.getParameter("url");
		String res = "잘못된 URL 입니다.";
		int fromIndex = -1;
		int counter = 0;

		// http 프로토콜을 입력 안했을 경우에 입력해줌
		if (url.toLowerCase().indexOf("http://") == -1) {
			url = "http://" + url;
		}

		// ROOT 주소를 가져오기 위해서
		String root_url = url;
		while ((fromIndex = url.toLowerCase().indexOf('/', fromIndex + 1)) > 0
				&& url.length() > fromIndex) {
			if (counter >= 2) {
				root_url = url.substring(0, fromIndex);
				break;
			}
			counter++;
		}

		try {
			Document doc = Jsoup.connect(url).get();
			Elements els = doc.getAllElements();
			for (Iterator<Element> Iter = els.iterator(); Iter.hasNext();) {
				Element e = Iter.next();
				String tagName = e.tagName().toLowerCase();
				if (tagName.equals("link")) {
					String href_url = e.attr("href");
					if (href_url.toLowerCase().indexOf("http") == -1) {
						href_url = root_url + href_url;
						e.attr("href", href_url);
					}
				} else if (tagName.equals("img")) {
					String src_url = e.attr("src");
					if (src_url.toLowerCase().indexOf("http") == -1) {
						src_url = root_url + src_url;
						e.attr("src", src_url);
					}
				} else if (tagName.equals("script")) {
					/*
					 * String src_url = e.attr("src"); if (!src_url.equals(""))
					 * { if (src_url.toLowerCase().indexOf("http") == -1) {
					 * src_url = root_url + src_url; e.attr("src", src_url); } }
					 */
					e.remove();
				} else if (tagName.equals("iframe")) {
					e.remove();
				}
			}
			res = doc.html();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			response.getWriter().write(res);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
