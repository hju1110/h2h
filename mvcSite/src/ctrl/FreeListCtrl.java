package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;

@WebServlet("/freeList")
public class FreeListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;       
    public FreeListCtrl() {  super();  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0;
		// ������ ��ȣ,	 ������ ũ��, 	���ũ�� ,	���ڵ�(���ñ�)���� , ������ ���� ���� ������ ���� 
		if (request.getParameter("cpage") != null) 
			cpage = Integer.parseInt(request.getParameter("cpage"));
		//cpage ���� ������ �޾Ƽ� int������ �� ��ȯ ��Ŵ (���Ȼ��� ������ ��������� �ؾ� �ϱ� ����)
		String where = " where fl_isview = 'y' ";
		String args = "", schargs = "";						//���� ��Ʈ���� ������ ���� 
		args = "&cpage=" + cpage;
		
		String schtype = request.getParameter("schtype");	// �˻� ���� (����, ����, ����+����)
		String keyword = request.getParameter("keyword");	// �˻��� 
		
		
		if (schtype == null || keyword == null) {
			schtype = ""; keyword = "";
			// ȭ��� �˻�� null �� ������ �ʰ� �ϱ� ���� �� ���ڿ���  ä�� 
		} else if (!schtype.equals("") && !keyword.equals("")) {
		//�˻� ���ǰ� �˻�� ��� ���� ��� 			
			URLEncoder.encode(keyword, "utf-8");
			// ������Ʈ������ �ְ� �޴� �˻�� �ѱ��� ��� �������� ���� ������ �߻��� �� �����Ƿ� �����ڵ�� ��ȯ 
			if (schtype.equals("tc")) {	// �˻� ������ ����+���� �ϰ��
				 where += " and (fl_title like '%" + keyword + "%' " +
					     " or fl_content like '%" + keyword + "%') ";
			} else {					// �˻� ������ ���� �̰ų� ������ ��� 
				 where += " and fl_" + schtype + " like '%" + keyword + "%' ";
			}
			schargs = "&schtype=" + schtype + "&keyword=" + keyword;
			args += schargs;
		}
		
		FreeProcSvc freeProcSvc = new FreeProcSvc();
		rcnt = freeProcSvc.getFreeListCount(where);
		// �˻��� �Խñ��� �� ������ �Խñ� �Ϸù�ȣ�� ��ü ������ �� ����� ���� �ʿ��� �� 
		pcnt = rcnt / psize;
		if (rcnt % psize > 0) pcnt++;		// ��ü ������ �� (������ ������ ��ȣ)
				
		ArrayList<FreeList> freeList = freeProcSvc.getFreeList(where, cpage, psize);
		// ���ȭ�鿡�� ������ �Խñ� ����� ArrayList<FreeList>������ �޾ƿ� 
		// �ʿ��� ��ŭ�� �޾ƿ��� ���� cpage�� psize�� �ʿ� 
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize); 		pageInfo.setCpage(cpage);	pageInfo.setPcnt(pcnt);
		pageInfo.setPsize(psize);		pageInfo.setRcnt(rcnt);
		pageInfo.setKeyword(keyword); 	pageInfo.setSchtype(schtype); 	
		pageInfo.setArgs(args);			pageInfo.setSchargs(schargs);
		// ����¡�� �˻��� �ʿ��� �������� pageInfo�� �ν��Ͻ��� ���� 
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("freeList", freeList);
		//request ��ü�� ������ ��û�� ���� ���ϰ� forward()�� �̵��ϴ� ���Ͽ��� ����� �� ��
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/bbs/free_list.jsp");
		dispatcher.forward(request, response);
	}
}
