package ctrl;

import java.io.*;
import java.net.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import svc.*;
import vo.*;

@Controller
public class ReviewCtrl {
	@Autowired
	 private ReviewSvc reviewSvc;

	    public void setReviewSvc(ReviewSvc reviewSvc) {
	        this.reviewSvc = reviewSvc;
	    }

	    @GetMapping("/reviewList")
	    public String reviewlist(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
			request.setCharacterEncoding("utf-8");
			int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 10, bsize = 10, num = 0;

			if (request.getParameter("cpage") != null)
				cpage = Integer.parseInt(request.getParameter("cpage"));
			
			String schtype = request.getParameter("schtype");
			String keyword = request.getParameter("keyword");
			String where = " where rl_isview = 'y' ";
			String args = "", schargs = "";
			
			if (schtype == null || keyword == null) {
				schtype = "";	keyword = "";
			} else if (!schtype.equals("") && !keyword.trim().equals("")) {
				URLEncoder.encode(keyword, "UTF-8");
				keyword = keyword.trim();
				if (schtype.equals("tc")) {	
					where += " and (rl_title like '%" + keyword + "%' or rl_content like '%" + keyword + "%') ";
				} else {
					where += " and rl_" + schtype + " like '%" + keyword + "%' ";
				}
				schargs = "&schtype=" + schtype + "&keyword=" + keyword;
			}
			args = "&cpage=" + cpage + schargs; 
			
			rcnt = reviewSvc.getReviewListCount(where);
			
	        List<ReviewList> reviewList = reviewSvc.getReviewList(where, cpage, psize);
	        
	        pcnt = rcnt / psize;	if (rcnt % psize > 0)	pcnt++;
			spage = (cpage - 1) / bsize * bsize + 1;
			num = rcnt - (psize * (cpage - 1));
			
			PageInfo pi = new PageInfo();
			pi.setBsize(bsize);		pi.setCpage(cpage);
			pi.setPcnt(pcnt);		pi.setPsize(psize);
			pi.setRcnt(rcnt);		pi.setSpage(spage);
			pi.setNum(num);
			
			pi.setSchtype(schtype);
			pi.setKeyword(keyword);
			pi.setArgs(args);
			pi.setSchargs(schargs);
	        
			model.addAttribute("reviewList", reviewList);
			model.addAttribute("pi", pi);
			
			return "review/reviewList";
	    }
	    @GetMapping("/reviewFormIn")
	    public String reviewInForm() {
	        return "review/review_form";
	    }
	    
	    @PostMapping("/reviewProcIn")
	    public String reviewProcIn(@RequestParam("rl_file") MultipartFile[] rl_file,
	            HttpServletRequest request, HttpServletResponse response) throws Exception {
	        request.setCharacterEncoding("utf-8");
	        HttpSession session = request.getSession();
			AdminInfo loginInfo = (AdminInfo)session.getAttribute("loginInfo");
			if (loginInfo == null) {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('로그인 후 이용가능합니다.');");
				out.println("location.href='login?url=reviewList';");
				out.println("</script>");
				out.close();
			}
	        
	        String uploadPath2 = "E:/lhj/spring/h2h/h2hAdmin/src/main/webapp/resources/img";
	        
	        List<String> piImgList = new ArrayList<>();
	        for (MultipartFile file : rl_file) {
	            if (!file.isEmpty()) {
	            	File saveFile2 = new File(uploadPath2, file.getOriginalFilename());	 
	                try {
	                    file.transferTo(saveFile2);
	                    piImgList.add(file.getOriginalFilename()); 
	                } catch (Exception e) {
	                    e.printStackTrace();
	                }
	            }
	        }
	        
	        String rl_writer = request.getParameter("rl_writer");
	        String rl_title = request.getParameter("rl_title");
	        String rl_content = request.getParameter("rl_content");
	        String rl_name = piImgList.get(0);
	        
	        ReviewList rl = new ReviewList();
	        rl.setRl_writer(rl_writer);
	        rl.setRl_content(rl_content);
	        rl.setRl_title(rl_title);
	        rl.setRl_name(rl_name);
	        
	        int result = reviewSvc.reviewInsert(rl);
	        if (result != 1) {   
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter out = response.getWriter();   
	            out.println("<script>");
	            out.println("alert('글 등록에 실패했습니다.'); history.back();");
	            out.println("</script>");
	            out.close();
	         } 
	        
	        return "redirect:/reviewList";       
	    }
	    @GetMapping("/reviewView")
	    public String reviewView(Model model, @RequestParam("rlidx") int rlidx,
	                             @RequestParam(value = "cpage", defaultValue = "1") int cpage,
	                             @RequestParam(value = "schtype", required = false) String schtype,
	                             @RequestParam(value = "keyword", required = false) String keyword,
	                             HttpServletRequest request) throws Exception {
	        request.setCharacterEncoding("utf-8");
	        
	        String args = "?cpage=" + cpage;
	        
	        if (schtype != null && !schtype.equals("") &&
	            keyword != null && !keyword.equals("")) {
	            keyword = URLEncoder.encode(keyword, "UTF-8"); 
	            args += "&schtype=" + schtype + "&keyword=" + keyword;
	        }
	        
	        ReviewList rl = reviewSvc.getReviewInfo(rlidx);	
	        model.addAttribute("rl", rl);
	        model.addAttribute("args", args);
	        
	        List<ReviewReply> reviewReply = reviewSvc.getReviewReply(rlidx);
	        model.addAttribute("reviewReply", reviewReply);
	        
	        return "review/reviewView";
	    }
	    
	    
	    @PostMapping("/addReviewReply")
	    public String addReviewReply(HttpServletRequest request) {
	        int rl_idx = Integer.parseInt(request.getParameter("rl_idx"));
	        String rr_writer = request.getParameter("rr_writer");
	        String rr_content = request.getParameter("rr_content");
	        String rr_date = request.getParameter("rr_date");
	        
	        ReviewReply rr = new ReviewReply();
	        rr.setRl_idx(rl_idx);
	        rr.setRr_writer(rr_writer);
	        rr.setRr_content(rr_content);
	        rr.setRr_date(rr_date);
	       
	        
	        reviewSvc.addReviewReply(rr);

	        return "redirect:/reviewView?rlidx=" + rl_idx;
	        
	    }
	    
	    @GetMapping("/reviewFormUp")
	    public String reviewUpForm(Model model, @RequestParam("rl_idx") int rl_idx) {
	        ReviewList rl = reviewSvc.getReviewInfo(rl_idx);
	        model.addAttribute("rl", rl);
	        

	        return "review/reviewupdateform";
	    }
	    



	    @PostMapping("/reviewProcUp")
	    public String reviewProcUp(@RequestParam("rl_file") MultipartFile[] rl_file,
	                               @RequestParam("rl_idx") int rl_idx,
	                               @RequestParam("rl_name") String rl_name,
	                               HttpServletRequest request, HttpServletResponse response) throws Exception {
	    				request.setCharacterEncoding("utf-8");

	           String uploadPath2 = "E:/lhj/spring/h2h/h2hAdmin/src/main/webapp/resources/img";

	           List<String> piImgList = new ArrayList<>();
	            for (MultipartFile file : rl_file) {
	                if (!file.isEmpty()) {
	                    File saveFile2 = new File(uploadPath2, file.getOriginalFilename());
	                    try {
	                        file.transferTo(saveFile2);
	                        piImgList.add(file.getOriginalFilename());
	                    } catch (Exception e) {
	                        e.printStackTrace();
	                    }
	                }
	            }

	            String rl_writer = request.getParameter("rl_writer");
	            String rl_title = request.getParameter("rl_title");
	            String rl_content = request.getParameter("rl_content");
	            String new_rl_name = piImgList.get(0);

	            String imagePath = uploadPath2 + "/" + rl_name;
	            File imageFile = new File(imagePath);
	            if (imageFile.exists()) {
	                imageFile.delete();
	            }

	            ReviewList rl = new ReviewList();
	            rl.setRl_idx(rl_idx);
	            rl.setRl_writer(rl_writer);
	            rl.setRl_content(rl_content);
	            rl.setRl_title(rl_title);
	            rl.setRl_name(new_rl_name);

	            int result = reviewSvc.reviewUpdate(rl);
	            if (result != 1) {
	                response.setContentType("text/html; charset=utf-8");
	                PrintWriter out = response.getWriter();
	                out.println("<script>");
	                out.println("alert('글 등록에 실패했습니다.'); history.back();");
	                out.println("</script>");
	                out.close();
	            }

	            return "redirect:/reviewList";
	        }

	    @RequestMapping("/downloadImage")
	    public void downloadImage(@RequestParam("filename") String filename, HttpServletResponse response) {
	        String imagePath = "E:/lhj/spring/h2hAdmin/src/main/webapp/resources/img" + "/" + filename;

	        File imageFile = new File(imagePath);
	        if (imageFile.exists()) {
	            try {
	                response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
	                response.setContentType("image/jpeg"); 

	                FileInputStream fis = new FileInputStream(imageFile);
	                ServletOutputStream os = response.getOutputStream();
	                byte[] buffer = new byte[4096];
	                int bytesRead = -1;
	                while ((bytesRead = fis.read(buffer)) != -1) {
	                    os.write(buffer, 0, bytesRead);
	                }
	                fis.close();
	                os.close();
	            } catch (IOException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	    @GetMapping("/reviewdeleteform")
	    public String reviewdeleteform(@RequestParam("rlidx") int rlidx) {
	        reviewSvc.unpublishReview(rlidx);

	        return "redirect:/reviewList";
	    }
	}


