package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;	
import svc.*;
import vo.*;


@WebServlet("/productList")
public class ProductListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ProductListCtrl() {  super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, spage = 0, psize = 12, bsize = 10, rcnt = 0, pcnt = 0;
		if (request.getParameter("cpage") != null) 
			cpage = Integer.parseInt(request.getParameter("cpage"));
		
		//검색조건 작업 : 대분류, 소분류, 가격대, 상품명, 브랜드 
		String where = "", schargs = ""; 
		String pcb = request.getParameter("pcb");	// 대분류 조건
		String pcs = request.getParameter("pcs");	// 소분류 조건 
		String sch = request.getParameter("sch");	// 검색조건(가격대p,상품명n,브랜드b)		
		if (pcb != null && !pcb.equals("")) {
			where += " and left(a.pcs_id, 2) = '" + pcb + "' ";
			schargs += "&pcb=" + pcb;
			
		}
			
		if (pcs != null && !pcs.equals("")) {
			where += " and a.pcs_id = '" + pcs + "' ";
			schargs += "&pcs=" + pcs;
		}
		if (sch != null && !sch.equals("")) {
		// 검색조건 : &sch=ntest,bB1:B2:B3,p100000~200000
			schargs += "&sch=" + sch;
			String[] arrSch = sch.split(",");
			for (int i = 0 ; i < arrSch.length ; i++) {
				char c = arrSch[i].charAt(0);
				if (c == 'n') {				// 상품명 검색일 경우('n'검색어)
					where += " and a.pi_name like '%" + arrSch[i].substring(1) + "%' ";
					
				} else if (c == 'b') {		// 브랜드 검색일 경우(b브랜드1:브랜드2)
				// where += " and (a.pb_id = '브1' or a.pb_id = '브2') "
					String[] arr = arrSch[i].substring(1).split(":");
					where += "and (";
					for (int j = 0; j < arr.length; j++) {
						where += (j == 0 ? "" : " or ") + "a.pb_id = '" + arr[j] + "' ";
					}
					where += ") ";
					
				} else if (c == 'p') {		// 가격대 검색일 경우 (p시작가~종료가)
					String sp = arrSch[i].substring(1,arrSch[i].indexOf('~'));
					if (sp != null && !sp.equals(""))
						where += " and a.pi_price >= " + sp;
					
					String ep = arrSch[i].substring(arrSch[i].indexOf('~') + 1);
					if (ep != null && !ep.equals(""))
						where += " and a.pi_price <= " + ep;
				}
			}
		}
		
		String orderBy = " order by "; // 목록 정렬 순서 
		String ob = request.getParameter("ob"); // 정렬조건
		if (ob == null || ob.equals(""))	ob = "a";
		String obargs = "&ob=" + ob;		//정렬조건을 위한 쿼리스트링
		switch (ob) {	
		case "a" :  							//등록 역순 (기본값)
			orderBy += " a.pi_date desc "; break;		
		case "b" :  							//판매량(인기순 )
			orderBy += " a.pi_sale desc "; break;
		case "c" :  							//낮은 가격순
			orderBy += " a.pi_price asc "; break;
		case "d" :  							//높은 가격순
			orderBy += " a.pi_price desc "; break;
		case "e" :  							//평점 높은 순
			orderBy += " a.pi_score desc "; break;
		case "f" :  							// 리뷰 많은 순
			orderBy += " a.pi_review desc "; break;
		case "g" :  							//조회수 많은 순
			orderBy += " a.pi_read desc "; break;	
		}		
		
		String v = request.getParameter("v");	// 보기 방식
		if (v == null || v.equals("")) v = "l"; // 
		// 목록형(l)과 갤러리형(g) 모두  페이지 크기는 12로 통일함 
		String vargs = "&v=" + v;				// 보기 방식을 위한 쿼리 스트링 
		
		ProductProcSvc productProcSvc = new ProductProcSvc();
		rcnt = productProcSvc.getProductCount(where);
		// 검색된 상품의 총 개수로 전체 페이지수를 구할 때 사용됨
		ArrayList<ProductInfo> productList = ProductProcSvc.getProductList(cpage, psize, where, orderBy);
		// 검색된 상품들 중 현재페이지에서 보여줄 상품 목록을 받아옴
		
		ArrayList<ProductCtgrSmall> smallList = new ArrayList<ProductCtgrSmall>();
		if (pcb != null && !pcb.equals("")) {			// 검색조건 중 대분류가 있으면
			smallList = productProcSvc.getCtgrSmallList(pcb);
			// 검색조건의 대분류에 속하는 소분류 목록을 받아옴
		}
		
		ArrayList<ProductBrand> brandList = new ArrayList<ProductBrand>();
		brandList = productProcSvc.getBrandList();
		// 검색조건으로 보여줄 브랜드들의 목록들을 받아옴 
		
		pcnt = rcnt / psize;
		if (rcnt % psize > 0) pcnt ++;
		spage = (cpage - 1) / bsize * bsize + 1;
		
		PageInfo pageInfo = new PageInfo();
		
		pageInfo.setBsize(bsize);	pageInfo.setCpage(cpage);
		pageInfo.setPsize(psize);	pageInfo.setPcnt(pcnt);
		pageInfo.setRcnt(rcnt);		pageInfo.setSpage(spage);
		pageInfo.setPcb(pcb);		pageInfo.setPcs(pcs);
		pageInfo.setSch(sch);		pageInfo.setOb(ob);
		pageInfo.setV(v);			pageInfo.setSchargs(schargs);
		pageInfo.setObargs(obargs); pageInfo.setVargs(vargs);
		// 페이징과 링크에 관련된 정보들을 pageInfo형 인스턴스에 저장
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("productList", productList);
		request.setAttribute("smallList", smallList);
		request.setAttribute("brandList", brandList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/product/product_list.jsp");
		dispatcher.forward(request, response);
	}
}
