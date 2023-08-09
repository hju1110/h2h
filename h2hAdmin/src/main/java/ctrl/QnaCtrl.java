package ctrl;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import svc.*;
import vo.*;


@Controller
public class QnaCtrl {
	@Autowired
    private QnaSvc qnaSvc;

    public void setQnaSvc(QnaSvc qnaSvc) {
    	this.qnaSvc = qnaSvc;
    }


    @GetMapping("/qnaList")
    public String qnalist(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 10, bsize = 10, num = 0;
		// 현재 페이지 번호, 페이지 수, 시작페이지, 게시글 수, 페이지 크기
		// 블록크기, 번호 등을 저장할 변수
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		// 보안상의 이유와 산술연산을 위해 int형으로 형변환함
		
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");
		String where = " where ql_isview = 'y' ";
		String args = "", schargs = "";
		
		if (schtype == null || keyword == null) {
			schtype = "";	keyword = "";
		} else if (!schtype.equals("") && !keyword.trim().equals("")) {
			URLEncoder.encode(keyword, "UTF-8");
			keyword = keyword.trim();
			if (schtype.equals("tc")) {	// 검색조건이 '제목 + 내용' 일 경
				where += " and (ql_title like '%" + keyword + "%' or rl_content like '%" + keyword + "%') ";
			} else {
				where += " and ql_" + schtype + " like '%" + keyword + "%' ";
			}
			schargs = "&schtype=" + schtype + "&keyword=" + keyword;
		}
		args = "&cpage=" + cpage + schargs; 
		
		rcnt = qnaSvc.getQnaListCount(where);
		
        List<QnaList> qnaList = qnaSvc.getQnaList(where, cpage, psize);
        
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
        
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("pi", pi);
		
		return "qna/qnaList";
    }
    /*
    @GetMapping("/qnaFormIn")
    public String qnaFormIn() {
        return "qna/qna_form";
    }
    @PostMapping("/qnaProcIn")
    public String qnaProcIn(@RequestParam("ql_file") MultipartFile[] ql_file,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");
        
        // 업로드 어드민 경로 지정
        String uploadPath2 = "E:/lms/spring/h2hAdmin/src/main/webapp/resources/img";
        
        List<String> piImgList = new ArrayList<>();
        for (MultipartFile file : ql_file) {
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

        int ql_ai_idx = Integer.parseInt(request.getParameter("ql_ai_idx"));
        String ql_title = request.getParameter("ql_title");
        String ql_content = request.getParameter("ql_content");
        String ql_img1 = piImgList.get(0);
        
        QnaList ql = new QnaList();
        ql.setQl_ai_idx(ql_ai_idx);
        ql.setQl_title(ql_title);
        ql.setQl_content(ql_content);
        ql.setQl_img1(ql_img1);
        
        int result = qnaSvc.qnaInsert(ql);
        if (result != 1) {   
            response.setContentType("text/html; charset=utf-8");
            PrintWriter out = response.getWriter();   
            out.println("<script>");
            out.println("alert('공지사항 등록에 실패 .'); history.back();");
            out.println("</script>");
            out.close();
         } 
        
        return "redirect:/qnaList";       
    }*/
    @GetMapping("/qnaView")
    public String qnaView(Model model, @RequestParam("qlidx") int qlidx,
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
        
        QnaList ql = qnaSvc.getQnaInfo(qlidx);	
        model.addAttribute("ql", ql);
        model.addAttribute("args", args);
      
        return "review/qnaView";
    }
}
