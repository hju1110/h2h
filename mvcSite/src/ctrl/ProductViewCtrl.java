package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;	
import svc.*;
import vo.*;


@WebServlet("/productView")
public class ProductViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ProductViewCtrl() { super(); }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String piid = request.getParameter("piid");
		
		// 1. ��ȸ�� ����
		ProductProcSvc productProcSvc = new ProductProcSvc();
		int result = productProcSvc.readUpdate(piid);
		
		
		 //2. ������ ��ǰ ���� �޾ƿ���
		ProductInfo productInfo = productProcSvc.getProductInfo(piid);
		if (productInfo == null) {	//�����ַ��� ��ǰ�� ���� ���
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();	
			out.println("<script>");
			out.println("alert('��ǰ������ �����ϴ�.'); history.back();");
			out.println("</script>");
			out.close();
		} 
		
		//3. �ش��ǰ�� �ı� ��� �޾ƿ���
		ArrayList<ReviewList> reviewList = productProcSvc.getReviewList(piid);
		

		// 4. ��ǰ�󼼺��� ȭ������ �̵� 		
		request.setAttribute("productInfo", productInfo);
		request.setAttribute("reviewList", reviewList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/product/product_view.jsp");
		dispatcher.forward(request, response);
	}

}
