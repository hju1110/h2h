package ctrl;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import svc.ProductProcSvc;
import vo.*;

@Controller
public class ProductCtrl {
	private ProductProcSvc productProcSvc;
	
	public void setProductProcSvc(ProductProcSvc productProcSvc) {
		this.productProcSvc = productProcSvc;
	}

	
	@GetMapping("/ProductProc")
	public String productList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		request.setCharacterEncoding("utf-8");
		int cpage = 1, spage = 0, psize = 12, bsize = 10, rcnt = 0, pcnt = 0;
		
		if (request.getParameter("cpage") != null) 
			cpage = Integer.parseInt(request.getParameter("cpage"));
		//�˻����� �۾� : ��з�, �Һз�, ���ݴ�, ��ǰ��, �귣�� 
		String where = "", schargs = ""; 
		
		String pcs = request.getParameter("pcs");	// ��з� ���� 
		String sch = request.getParameter("sch");	// �˻�����(���ݴ�p,��ǰ��n,�귣��b)		
		
		String orderBy = " order by "; // ��� ���� ���� 
		String ob = request.getParameter("ob"); // ��������
		if (ob == null || ob.equals(""))	ob = "a";
		String obargs = "&ob=" + ob;		//���������� ���� ������Ʈ��
		switch (ob) {	
		case "a" :  							//��� ���� (�⺻��)
			orderBy += " pi_date desc "; break;		
		case "b" :  							//�Ǹŷ�(�α�� )
			orderBy += " pi_sale desc "; break;
		case "c" :  							//���� ���ݼ�
			orderBy += " pi_price asc "; break;
		case "d" :  							//���� ���ݼ�
			orderBy += " pi_price desc "; break;
		case "e" :  							//��ȸ�� ���� ��
			orderBy += " pi_read desc "; break;	
		case "f" :  							//���ƿ� ���� ��
			orderBy += " pi_good desc "; break;	
		}		
		
		
		String v = request.getParameter("v");	// ���� ���
		if (v == null || v.equals("")) v = "l"; // 
		// �����(l)�� ��������(g) ���  ������ ũ��� 12�� ������ 
		String vargs = "&v=" + v;				// ���� ����� ���� ���� ��Ʈ�� 
		
		
		rcnt = productProcSvc.getProductCount(where);
		

		List<ProductInfo> productList = productProcSvc.getProductList(cpage, psize, orderBy);
	
		
		pcnt = rcnt / psize;
		if (rcnt % psize > 0) pcnt ++;
		spage = (cpage - 1) / bsize * bsize + 1;
		
		PageInfo pageInfo = new PageInfo();
		
		pageInfo.setBsize(bsize);	pageInfo.setCpage(cpage);
		pageInfo.setPsize(psize);	pageInfo.setPcnt(pcnt);
		pageInfo.setRcnt(rcnt);		pageInfo.setSpage(spage);
		pageInfo.setPcs(pcs);
		pageInfo.setSch(sch);		pageInfo.setOb(ob);
		pageInfo.setV(v);			pageInfo.setSchargs(schargs);
		pageInfo.setObargs(obargs); pageInfo.setVargs(vargs);
		// ����¡�� ��ũ�� ���õ� �������� pageInfo�� �ν��Ͻ��� ����
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("productList", productList);
				
		return "product/product_list";	
		
		
	
	}
	
	@GetMapping("/ProductView")
	public String productView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		String piid = request.getParameter("piid");
		// 
		int result = productProcSvc.readUpdate(piid);
		
		ProductInfo productInfo = productProcSvc.getProductInfo(piid);
		if (productInfo == null) {	//
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();	
			out.println("<script>");
			out.println("alert('등록된 상품이 없습니다.'); history.back();");
			out.println("</script>");
			out.close();
		} 
		
		
		request.setAttribute("productInfo", productInfo);
		/*String args = "?schYear=" + si_date.substring(0, 4) + 
				"&schMonth=" + si_date.substring(5, 7);
			return "redirect:/schedule" + args;*/
		String args = "?piid=" + productInfo.getPi_id();
		
		
		return "product/product_view";
	}
	
}
