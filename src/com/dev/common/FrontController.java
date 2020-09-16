package com.dev.common;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dev.controller.MemberDeleteController;
import com.dev.controller.MemberInsertController;
import com.dev.controller.MemberListController;
import com.dev.controller.MemberSearchController;
import com.dev.controller.MemberSearchPageController;
import com.dev.controller.MemberUpdateController;
import com.dev.controller.member.ChartData;
import com.dev.controller.users.DeleteUsers;
import com.dev.controller.users.GetUsers;
import com.dev.controller.users.GetUsersList;
import com.dev.controller.users.InsertUsers;
import com.dev.controller.users.UpdateUsers;

/**
 * Servlet implementation class FrontController
 */

/* @WebServlet(name="front", 
			urlPatterns = "*.do", //.do가 나올때는 /있으면 안됨
			initParams = 
			{
				@WebInitParam(name = "charset", value="UTF-8")
			})
*/
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	String charset = null;
	HashMap<String, Controller> list = null;
	
    @Override
	public void init(ServletConfig config) throws ServletException {
    	charset = config.getInitParameter("charset");
    	list = new HashMap<String, Controller>();
    	list.put("/memberInsert.do", new MemberInsertController());
    	list.put("/memberUpdate.do", new MemberUpdateController());
    	list.put("/admin/memberSearchPage.do", new MemberSearchPageController());
    	list.put("/memberSearch.do", new MemberSearchController());
    	list.put("/memberDelete.do", new MemberDeleteController());
    	list.put("/memberList.do", new MemberListController());
    	
    	//user ajax처리
    	list.put("/ajax/DeleteUsers.do", new DeleteUsers());
    	list.put("/ajax/GetUsers.do", new GetUsers());
    	list.put("/ajax/GetUsersList.do", new GetUsersList());
    	list.put("/ajax/InsertUsers.do", new InsertUsers());
    	list.put("/ajax/UpdateUsers.do", new UpdateUsers());
    	
    	//chart data ajax처리
    	list.put("/ajax/ChartData.do", new ChartData());
    }
    
    
//frontController쓰는 이유는 각 controller에 넣을 설정 값을 이곳에 한번 쓰면 끝나서 편하기 때문
    
    
    
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding(charset);
		response.setContentType("text/html; charset=UTF-8"); //응답 보낼때 한글을 인코딩해서 보냄
		String uri = request.getRequestURI();				// frontWeb/memberInsert.do
		String contextPath = request.getContextPath(); 		// frontWeb
		String path = uri.substring(contextPath.length()); 	// /memberInsert.do
		Controller subController = list.get(path);			// /memberInsert.do받아서 변수 하나 지정해서 리스트에 넣기 
		subController.execute(request, response);			// 지정된 변수를 실행 시키기(execute는 추상메소드라서 새로운 클래스에서 실행 시킬 수 있다)
	}

}
