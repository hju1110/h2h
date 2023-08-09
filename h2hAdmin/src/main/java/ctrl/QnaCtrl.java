package ctrl;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
    public String qnalist(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		AdminInfo loginInfo = (AdminInfo)session.getAttribute("loginInfo");
		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용가능합니다.');");
			out.println("location.href='login?url=qnaList';");
			out.println("</script>");
			out.close();
		}
		
		int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 10, bsize = 10, num = 0;
		// ���� ������ ��ȣ, ������ ��, ����������, �Խñ� ��, ������ ũ��
		// ���ũ��, ��ȣ ���� ������ ����
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		// ���Ȼ��� ������ ��������� ���� int������ ����ȯ��
		
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");
		String where = " where ql_isview = 'y' ";
		String args = "", schargs = "";
		
		if (schtype == null || keyword == null) {
			schtype = "";	keyword = "";
		} else if (!schtype.equals("") && !keyword.trim().equals("")) {
			URLEncoder.encode(keyword, "UTF-8");
			keyword = keyword.trim();
			if (schtype.equals("tc")) {	// �˻������� '���� + ����' �� ��
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
		// ����¡�� �ʿ��� ������� �˻������� pageInfo�� �ν��Ͻ��� ����
        
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
        
        // ���ε� ���� ��� ����
        String uploadPath2 = "E:/lms/spring/h2hAdmin/src/main/webapp/resources/img";
        
        List<String> piImgList = new ArrayList<>();
        for (MultipartFile file : ql_file) {
            if (!file.isEmpty()) {
            	File saveFile2 = new File(uploadPath2, file.getOriginalFilename());	 // ����
                try {
                    file.transferTo(saveFile2); // ����
                    piImgList.add(file.getOriginalFilename()); // ���ϸ� �߰�
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
            out.println("alert('�������� ��Ͽ� ���� .'); history.back();");
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
            keyword = URLEncoder.encode(keyword, "UTF-8"); // URLEncoder�� ����� ������ �Ҵ������ �մϴ�.
            args += "&schtype=" + schtype + "&keyword=" + keyword;
        }
        
        QnaList ql = qnaSvc.getQnaInfo(qlidx);	
        model.addAttribute("ql", ql);
        model.addAttribute("args", args);
      
        return "review/qnaView";
    }
}
