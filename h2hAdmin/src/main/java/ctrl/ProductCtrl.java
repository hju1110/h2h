package ctrl;

import java.io.File;
import java.io.PrintWriter;
import java.lang.ProcessBuilder.Redirect;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import svc.ProductProcSvc;
import vo.*;

@Controller
public class ProductCtrl {
	private ProductProcSvc productProcSvc;
	
	public void setProductProcSvc(ProductProcSvc productProcSvc) {
		this.productProcSvc = productProcSvc;
	}

	
	@GetMapping("/productList")
	public String productList(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		AdminInfo loginInfo = (AdminInfo)session.getAttribute("loginInfo");
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용가능합니다.');");
			out.println("location.href='login?url=productList';");
			out.println("</script>");
			out.close();
		}
		
		int cpage = 1, spage = 0, psize = 6, bsize = 10, rcnt = 0, pcnt = 0;
		
		if (request.getParameter("cpage") != null) 
			cpage = Integer.parseInt(request.getParameter("cpage"));
	
		String where = "", schargs = ""; 
		
		String pcs = request.getParameter("pcs");	
		String sch = request.getParameter("sch");		
		
			String orderBy = " order by "; 
		String ob = request.getParameter("ob"); 
		if (ob == null || ob.equals(""))	ob = "a";
		String obargs = "&ob=" + ob;		
		switch (ob) {	
		case "a" :  							
			orderBy += " pi_date desc "; break;		
		case "b" :  							
			orderBy += " pi_sale desc "; break;
		case "c" :  							
			orderBy += " pi_price asc "; break;
		case "d" :  						
			orderBy += " pi_price desc "; break;
		case "e" :  						
			orderBy += " pi_read desc "; break;	
		case "f" :  							
			orderBy += " pi_good desc "; break;	
		}		
		
	
		String v = request.getParameter("v");	
		if (v == null || v.equals("")) v = "l"; 
	
		String vargs = "&v=" + v;				
		
		
		rcnt = productProcSvc.getProductCount(where);
	

		List<ProductInfo> productList = productProcSvc.getProductList(cpage, psize);
		
		pcnt = rcnt / psize;
		if (rcnt % psize > 0) pcnt ++;
		spage = (cpage - 1) / bsize * bsize + 1;
		
		PageInfo pageInfo = new PageInfo();
		
		pageInfo.setBsize(bsize);	pageInfo.setCpage(cpage);
		pageInfo.setPsize(psize);	pageInfo.setPcnt(pcnt);
		pageInfo.setRcnt(rcnt);		pageInfo.setSpage(spage);
		pageInfo.setPcs(pcs);pageInfo.setSch(sch);pageInfo.setV(v);	
		pageInfo.setOb(ob); pageInfo.setObargs(obargs); pageInfo.setVargs(vargs);
		pageInfo.setSchargs(schargs);
		
	
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("productList", productList);
				
		return "product/product_list";	
	
	}
	
	@GetMapping("/ProductView")
	public String productView(HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.setCharacterEncoding("utf-8");
		String piid = request.getParameter("piid");
		int result = productProcSvc.readUpdate(piid);
		
		ProductInfo productInfo = productProcSvc.getProductInfo(piid);
		if (productInfo == null) {	
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();	
			out.println("<script>");
			out.println("alert('濡쒓렇�씤�씠 �븘�슂�빀�땲�떎.'); history.back();");
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
	
	@PostMapping("/productInfo")
    public String productProc(@RequestParam("pi_img") MultipartFile[] pi_img,@RequestParam("pi_desc1") MultipartFile[] pi_desc1,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
       
      
      //  String uploadPath1 = "C:/lns/spring/h2hFront/src/main/webapp/resources/img";	
       // String uploadPath2 = "C:/lns/spring/h2hAdmin/src/main/webapp/resources/img";	
    	String uploadPath1 = "E:/lhj/spring/h2hFront/src/main/webapp/resources/img";	
        String uploadPath2 = "E:/lhj/spring/h2hAdmin/src/main/webapp/resources/img";	
    	
    	List<String> piImgList = new ArrayList<>();
        for (MultipartFile file : pi_img) {
            if (!file.isEmpty()) { // �뙆�씪�씠 �뾽濡쒕뱶�맂 寃쎌슦�뿉留� 泥섎━
                File saveFile1 = new File(uploadPath1, file.getOriginalFilename());	
                File saveFile2 = new File(uploadPath2, file.getOriginalFilename()); 
                try {
                    file.transferTo(saveFile1);	// �봽濡좏듃
                    file.transferTo(saveFile2);	// �뼱�뱶誘�
                    piImgList.add(file.getOriginalFilename());
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        // �몢 踰덉㎏ �뙆�씪 �뾽濡쒕뱶 泥섎━
        List<String> piDescList = new ArrayList<>();
        for (MultipartFile file : pi_desc1) {
            if (!file.isEmpty()) { // �뙆�씪�씠 �뾽濡쒕뱶�맂 寃쎌슦�뿉留� 泥섎━
                File saveFile1 = new File(uploadPath1, file.getOriginalFilename());	// �봽濡좏듃
                File saveFile2 = new File(uploadPath2, file.getOriginalFilename());	// �뼱�뱶誘�
                try {
                    file.transferTo(saveFile1);	// �봽濡좏듃
                    file.transferTo(saveFile2);	// �뼱�뱶誘�
                    piDescList.add(file.getOriginalFilename());
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
	    
      
	    String pi_id = request.getParameter("pi_id");
	    String pcs_id = request.getParameter("pcs_id");
	    String pi_name = request.getParameter("pi_name");
	    int pi_price = Integer.parseInt(request.getParameter("pi_price"));
	    int pi_stock = Integer.parseInt(request.getParameter("pi_stock"));
	    String pi_img1 = piImgList.get(0);
	    String pi_img2 = piImgList.get(1);
	    String pi_img3 = piImgList.get(2);
	    String pi_desc = piDescList.get(0);
		ProductInfo pi = new ProductInfo(pi_id, pcs_id, pi_name, pi_price, pi_stock, pi_img1, pi_img2, pi_img3, pi_desc);
	    
        pi.setPi_id(pi_id);
        pi.setPcs_id(pcs_id);
        pi.setPi_name(pi_name);
        pi.setPi_price(pi_price);
        pi.setPi_stock(pi_stock);
        pi.setPi_img1(pi_img1);
        pi.setPi_img2(pi_img2);
        pi.setPi_img3(pi_img3);
        pi.setPi_desc(pi_desc);
        
        
        int result = productProcSvc.productInsert(pi);
        
        
        return "redirect:/productList";	

    }
    
    @GetMapping("/productIn")
	public String productIn(HttpServletRequest request, HttpServletResponse response) throws Exception{
		return "product/product_in";
    }
	
	@GetMapping("/productList1")
	public String productList1(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		request.setCharacterEncoding("utf-8");
		int cpage = 1, spage = 0, psize = 6, bsize = 10, rcnt = 0, pcnt = 0;
		
		if (request.getParameter("cpage") != null) 
			cpage = Integer.parseInt(request.getParameter("cpage"));
	
		String where = "", schargs = ""; 
		
		String pcs = request.getParameter("pcs");	
		String sch = request.getParameter("sch");		
		
			String orderBy = " order by "; 
		String ob = request.getParameter("ob"); 
		if (ob == null || ob.equals(""))	ob = "a";
		String obargs = "&ob=" + ob;		
		switch (ob) {	
		case "a" :  							
			orderBy += " pi_date desc "; break;		
		case "b" :  							
			orderBy += " pi_sale desc "; break;
		case "c" :  							
			orderBy += " pi_price asc "; break;
		case "d" :  						
			orderBy += " pi_price desc "; break;
		case "e" :  						
			orderBy += " pi_read desc "; break;	
		case "f" :  							
			orderBy += " pi_good desc "; break;	
		}		
		
	
		String v = request.getParameter("v");	
		if (v == null || v.equals("")) v = "l"; 
	
		String vargs = "&v=" + v;				
		
		
		rcnt = productProcSvc.getProductCount(where);
	

		List<ProductInfo> productList = productProcSvc.getProductList1(cpage, psize);
		
		pcnt = rcnt / psize;
		if (rcnt % psize > 0) pcnt ++;
		spage = (cpage - 1) / bsize * bsize + 1;
		
		PageInfo pageInfo = new PageInfo();
		
		pageInfo.setBsize(bsize);	pageInfo.setCpage(cpage);
		pageInfo.setPsize(psize);	pageInfo.setPcnt(pcnt);
		pageInfo.setRcnt(rcnt);		pageInfo.setSpage(spage);
		pageInfo.setPcs(pcs);pageInfo.setSch(sch);pageInfo.setV(v);	
		pageInfo.setOb(ob); pageInfo.setObargs(obargs); pageInfo.setVargs(vargs);
		pageInfo.setSchargs(schargs);
		
	
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("productList", productList);
				
		return "product/product_listx";	
	
	}
	@GetMapping("/productUp")
	public String productUp(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String pi_id = request.getParameter("piid");
		ProductInfo pi = productProcSvc.productUp(pi_id);
		request.setAttribute("pi", pi);	
		
		return "product/product_up";
    }
	@PostMapping("/productInfoUp")
    public String productInfoUp(@RequestParam("pi_img") MultipartFile[] pi_img,@RequestParam("pi_desc1") MultipartFile[] pi_desc1,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
       
      
    	String uploadPath1 = "E:/lhj/spring/h2hFront/src/main/webapp/resources/img";	// �뾽濡쒕뱶 �봽濡좏듃 寃쎈줈 吏��젙
    	String uploadPath2 = "E:/lhj/spring/h2hAdmin/src/main/webapp/resources/img";	// �뾽濡쒕뱶 �뼱�뱶誘�  寃쎈줈 吏��젙
    	
    	List<String> piImgList = new ArrayList<>();
        for (MultipartFile file : pi_img) {
            if (!file.isEmpty()) { // �뙆�씪�씠 �뾽濡쒕뱶�맂 寃쎌슦�뿉留� 泥섎━
                File saveFile1 = new File(uploadPath1, file.getOriginalFilename());	// �봽濡좏듃
                File saveFile2 = new File(uploadPath2, file.getOriginalFilename()); // �뼱�뱶誘�
                try {
                    file.transferTo(saveFile1);	// �봽濡좏듃
                    file.transferTo(saveFile2);	// �뼱�뱶誘�
                    piImgList.add(file.getOriginalFilename());
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        // �몢 踰덉㎏ �뙆�씪 �뾽濡쒕뱶 泥섎━
        List<String> piDescList = new ArrayList<>();
        for (MultipartFile file : pi_desc1) {
            if (!file.isEmpty()) { // �뙆�씪�씠 �뾽濡쒕뱶�맂 寃쎌슦�뿉留� 泥섎━
                File saveFile1 = new File(uploadPath1, file.getOriginalFilename());	// �봽濡좏듃
                File saveFile2 = new File(uploadPath2, file.getOriginalFilename());	// �뼱�뱶誘�
                try {
                    file.transferTo(saveFile1);	// �봽濡좏듃
                    file.transferTo(saveFile2);	// �뼱�뱶誘�
                    piDescList.add(file.getOriginalFilename());
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
	    
      
	    String pi_id = request.getParameter("pi_id");
	    String pcs_id = request.getParameter("pcs_id");
	    String pi_name = request.getParameter("pi_name");
	    int pi_price = Integer.parseInt(request.getParameter("pi_price"));
	    int pi_stock = Integer.parseInt(request.getParameter("pi_stock"));
	    String pi_img1 = piImgList.get(0);
	    String pi_img2 = piImgList.get(1);
	    String pi_img3 = piImgList.get(2);
	    String pi_desc = piDescList.get(0);
		ProductInfo pi = new ProductInfo(pi_id, pcs_id, pi_name, pi_price, pi_stock, pi_img1, pi_img2, pi_img3, pi_desc);
	    
        pi.setPi_id(pi_id);
        pi.setPcs_id(pcs_id);
        pi.setPi_name(pi_name);
        pi.setPi_price(pi_price);
        pi.setPi_stock(pi_stock);
        pi.setPi_img1(pi_img1);
        pi.setPi_img2(pi_img2);
        pi.setPi_img3(pi_img3);
        pi.setPi_desc(pi_desc);
        
        
        int result = productProcSvc.productUpdate(pi);
        
        
        return "redirect:/productList";	

    }
}
