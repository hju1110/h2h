package ctrl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
	    public String reviewlist(Model model, HttpServletRequest request) throws Exception {
			request.setCharacterEncoding("utf-8");
			int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 10, bsize = 10, num = 0;
			// 현재 페이지 번호, 페이지 수, 시작페이지, 게시글 수, 페이지 크기
			// 블록크기, 번호 등을 저장할 변수
			if (request.getParameter("cpage") != null)
				cpage = Integer.parseInt(request.getParameter("cpage"));
			// 보안상의 이유와 산술연산을 위해 int형으로 형변환함
			
			String schtype = request.getParameter("schtype");
			String keyword = request.getParameter("keyword");
			String where = " where rl_isview = 'y' ";
			String args = "", schargs = "";
			
			if (schtype == null || keyword == null) {
				schtype = "";	keyword = "";
			} else if (!schtype.equals("") && !keyword.trim().equals("")) {
				URLEncoder.encode(keyword, "UTF-8");
				keyword = keyword.trim();
				if (schtype.equals("tc")) {	// 검색조건이 '제목 + 내용' 일 경
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
			// 페이징에 필요한 정보들과 검색조건을 pageInfo에 인스턴스에 저장
	        
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
	        
	        // 업로드 어드민 경로 지정
	        String uploadPath2 = "E:/lms/spring/h2hAdmin/src/main/webapp/resources/img";
	        
	        List<String> piImgList = new ArrayList<>();
	        for (MultipartFile file : rl_file) {
	            if (!file.isEmpty()) {
	            	File saveFile2 = new File(uploadPath2, file.getOriginalFilename());	 // 어드민
	                try {
	                    file.transferTo(saveFile2); // 어드민
	                    piImgList.add(file.getOriginalFilename()); // 파일명 추가
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
	            out.println("alert('공지사항 등록에 실패 .'); history.back();");
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
	        
	        // System.out.println("nlidx: " + nlidx);
	        // System.out.println("cpage: " + cpage);
	        
	        String args = "?cpage=" + cpage;
	        
	        if (schtype != null && !schtype.equals("") &&
	            keyword != null && !keyword.equals("")) {
	            keyword = URLEncoder.encode(keyword, "UTF-8"); // URLEncoder의 결과를 변수에 할당해줘야 합니다.
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
	        // 댓글 등록 처리
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

	        // 이후 로직에서 rl_idx, rr_writer, rr_content 정보를 활용하여 댓글을 등록하는 코드를 작성합니다.

	        // 리다이렉트하여 댓글 목록을 보여줍니다.
	        return "redirect:/reviewView?rlidx=" + rl_idx;
	    }
	    
	    @GetMapping("/reviewFormUp")
	    public String reviewUpForm(Model model, @RequestParam("rl_idx") int rl_idx) {
	        // 게시글 수정 페이지로 이동하기 위한 컨트롤러 메서드
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

	            // 업로드 어드민 경로 지정
	            String uploadPath2 = "E:/lms/spring/h2hAdmin/src/main/webapp/resources/img";

	            // 기존 이미지 파일 삭제 후 새로운 이미지 업로드
	            List<String> piImgList = new ArrayList<>();
	            for (MultipartFile file : rl_file) {
	                if (!file.isEmpty()) {
	                    File saveFile2 = new File(uploadPath2, file.getOriginalFilename()); // 어드민
	                    try {
	                        file.transferTo(saveFile2); // 어드민
	                        piImgList.add(file.getOriginalFilename()); // 파일명 추가
	                    } catch (Exception e) {
	                        e.printStackTrace();
	                    }
	                }
	            }

	            String rl_writer = request.getParameter("rl_writer");
	            String rl_title = request.getParameter("rl_title");
	            String rl_content = request.getParameter("rl_content");
	            String new_rl_name = piImgList.get(0);

	            // 기존 이미지 파일 삭제
	            String imagePath = uploadPath2 + "/" + rl_name;
	            File imageFile = new File(imagePath);
	            if (imageFile.exists()) {
	                imageFile.delete();
	            }

	            // 새로운 이미지 파일명으로 업데이트
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
	                out.println("alert('게시글 수정에 실패하였습니다.'); history.back();");
	                out.println("</script>");
	                out.close();
	            }

	            return "redirect:/reviewList";
	        }
	    /*
	    @RequestMapping("/reviewList")
	    public String reviewList(Model model) {
	        List<ReviewReply> reviewList = reviewSvc.getReviewCommentCount();
	        model.addAttribute("reviewList", reviewList);
	        // ...
	        return "review/reviewList";
	    }*/
    

	    
	    @RequestMapping("/downloadImage")
	    public void downloadImage(@RequestParam("filename") String filename, HttpServletResponse response) {
	        // 이미지 파일의 전체 경로를 생성합니다.
	        String imagePath = "E:/lms/spring/h2hAdmin/src/main/webapp/resources/img" + "/" + filename;

	        // 이하 코드는 이전과 동일합니다.
	        File imageFile = new File(imagePath);
	        if (imageFile.exists()) {
	            try {
	                response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
	                response.setContentType("image/jpeg"); // 이미지 파일 타입에 맞게 설정

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
	}


