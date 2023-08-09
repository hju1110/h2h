package ctrl;

import java.io.*;
import java.net.*;
import java.util.*;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.ui.*;
import svc.*;
import vo.*;

@Controller
public class NoticeListCtrl {
    private NoticeSvc noticeSvc;

    public void setNoticeSvc(NoticeSvc noticeSvc) {
        this.noticeSvc = noticeSvc;
    }

    @GetMapping("/noticeList")
    public String noticelist(Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, pcnt = 0, spage = 0, rcnt = 0, psize = 10, bsize = 10, num = 0;
		// �쁽�옱 �럹�씠吏� 踰덊샇, �럹�씠吏� �닔, �떆�옉�럹�씠吏�, 寃뚯떆湲� �닔, �럹�씠吏� �겕湲�
		// 釉붾줉�겕湲�, 踰덊샇 �벑�쓣 ���옣�븷 蹂��닔
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		// 蹂댁븞�긽�쓽 �씠�쑀�� �궛�닠�뿰�궛�쓣 �쐞�빐 int�삎�쑝濡� �삎蹂��솚�븿
		
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");
		String where = " where nl_isview = 'y' ";
		String args = "", schargs = "";
		
		if (schtype == null || keyword == null) {
			schtype = "";	keyword = "";
		} else if (!schtype.equals("") && !keyword.trim().equals("")) {
			URLEncoder.encode(keyword, "UTF-8");
			keyword = keyword.trim();
			if (schtype.equals("tc")) {	// 寃��깋議곌굔�씠 '�젣紐� + �궡�슜' �씪 寃�
				where += " and (nl_title like '%" + keyword + "%' or nl_content like '%" + keyword + "%') ";
			} else {
				where += " and nl_" + schtype + " like '%" + keyword + "%' ";
			}
			schargs = "&schtype=" + schtype + "&keyword=" + keyword;
		}
		args = "&cpage=" + cpage + schargs; 
		
		rcnt = noticeSvc.getNoticeListCount(where);
		
        List<NoticeList> noticeList = noticeSvc.getNoticeList(where, cpage, psize);
        
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
		// �럹�씠吏뺤뿉 �븘�슂�븳 �젙蹂대뱾怨� 寃��깋議곌굔�쓣 pageInfo�뿉 �씤�뒪�꽩�뒪�뿉 ���옣
        
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pi", pi);
		
		return "notice/noticeList";
    }
    @GetMapping("/noticeFormIn")
    public String noticeInForm() {
        return "notice/notice_form";
    }

    @PostMapping("/noticeProcIn")
    public String noticeProcIn(@RequestParam("nl_file") MultipartFile[] nl_file,
    		HttpServletRequest request, HttpServletResponse response) throws Exception {
    	request.setCharacterEncoding("utf-8");
    	
    	String uploadPath1 = "E:/lms/spring/h2h/h2hFront/src/main/webapp/resources/img";   // �뾽濡쒕뱶 �봽濡좏듃 寃쎈줈 吏��젙
        
        List<String> piImgList = new ArrayList<>();
        if (nl_file != null) {
            for (MultipartFile file : nl_file) {
                if (!file.isEmpty()) {
                    File saveFile1 = new File(uploadPath1, file.getOriginalFilename());
                    try {
                        file.transferTo(saveFile1);
                        piImgList.add(file.getOriginalFilename());
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        
        String nl_writer = request.getParameter("nl_writer");
        String nl_title = request.getParameter("nl_title");
        String nl_content = request.getParameter("nl_content");
        String nl_name = piImgList.isEmpty() ? "" : piImgList.get(0);
        
        NoticeList nl = new NoticeList();
        nl.setNl_writer(nl_writer);
        nl.setNl_content(nl_content);
        nl.setNl_title(nl_title);
        nl.setNl_name(nl_name);
        
        int result = noticeSvc.noticeInsert(nl);
        if (result != 1) {   
            response.setContentType("text/html; charset=utf-8");
            PrintWriter out = response.getWriter();   
            out.println("<script>");
            out.println("alert('글 등록에 실패했습니다.'); history.back();");
            out.println("</script>");
            out.close();
        } 
        
        
		return "redirect:/noticeList";       
    }


    
    @GetMapping("/noticeView")
    public String noticeView(Model model, @RequestParam("nlidx") int nlidx,
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
            keyword = URLEncoder.encode(keyword, "UTF-8"); // URLEncoder�쓽 寃곌낵瑜� 蹂��닔�뿉 �븷�떦�빐以섏빞 �빀�땲�떎.
            args += "&schtype=" + schtype + "&keyword=" + keyword;
        }
        
        NoticeList nl = noticeSvc.getNoticeInfo(nlidx);	
        model.addAttribute("nl", nl);
        model.addAttribute("args", args);
        
        return "notice/noticeView";
    }

    @GetMapping("/noticeFormUp")
    public String noticeUpForm(Model model, @RequestParam("nl_idx") int nl_idx) {

        NoticeList nl = noticeSvc.getNoticeInfo(nl_idx);
        model.addAttribute("nl", nl);

        return "notice/noticeupdateform";
    }

    @PostMapping("/noticeProcUp")
    public String noticeProcUp(@RequestParam("nl_file") MultipartFile[] nl_file,
                               @RequestParam("nl_idx") int nl_idx,
                               @RequestParam("nl_name") String nl_name,
                               HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");

       String uploadPath2 = "E:/lms/h2h/spring/h2hAdmin/src/main/webapp/resources/img";
        
        // 湲곗〈 �씠誘몄� �뙆�씪 �궘�젣 �썑 �깉濡쒖슫 �씠誘몄� �뾽濡쒕뱶
        List<String> piImgList = new ArrayList<>();
        for (MultipartFile file : nl_file) {
            if (!file.isEmpty()) {
                File saveFile2 = new File(uploadPath2, file.getOriginalFilename()); // �뼱�뱶誘�
                try {
                    file.transferTo(saveFile2); // �뼱�뱶誘�
                    piImgList.add(file.getOriginalFilename()); // �뙆�씪紐� 異붽�
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        String nl_writer = request.getParameter("nl_writer");
        String nl_title = request.getParameter("nl_title");
        // 鍮� 臾몄옄�뿴濡� 珥덇린�솕�븯�뿬 NULL 媛� 諛⑹�
        String nl_content = request.getParameter("nl_content") != null ? request.getParameter("nl_content") : "";
        String new_nl_name = piImgList.isEmpty() ? nl_name : piImgList.get(0);

        // 湲곗〈 �씠誘몄� �뙆�씪 �궘�젣
        String imagePath = uploadPath2 + "/" + nl_name;
        File imageFile = new File(imagePath);
        if (imageFile.exists()) {
            imageFile.delete();
        }

        // �깉濡쒖슫 �씠誘몄� �뙆�씪紐낆쑝濡� �뾽�뜲�씠�듃
        NoticeList nl = new NoticeList();
        nl.setNl_idx(nl_idx);
        nl.setNl_writer(nl_writer);
        nl.setNl_content(nl_content);
        nl.setNl_title(nl_title);
        nl.setNl_name(new_nl_name);

        int result = noticeSvc.noticeUpdate(nl);
        if (result != 1) {
            response.setContentType("text/html; charset=utf-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('寃뚯떆湲� �닔�젙�뿉 �떎�뙣�븯���뒿�땲�떎.'); history.back();");
            out.println("</script>");
            out.close();
        }

        return "redirect:/noticeList";
    }
    @GetMapping("/noticedeleteform")
    public String noticedeleteform(@RequestParam("nlidx") int nlidx) {
        // 여기에서 해당 게시글의 nl_isview를 'n'으로 업데이트하거나 삭제 작업 수행
        noticeSvc.unpublishNotice(nlidx);

        return "redirect:/noticeList"; // 게시글 목록 페이지로 리다이렉트
    }

}