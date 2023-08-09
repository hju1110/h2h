package dao;

import java.sql.*;
import java.util.List;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import vo.*;

public class NoticeDao {
    private JdbcTemplate jdbc;


    // 생성자
    public NoticeDao(DataSource dataSource) {
        this.jdbc = new JdbcTemplate(dataSource);
    }
    
    
    public int getNoticeListCount(String where) {
       // 검색된(검색어가 있을 경우) 게시글의 총 개수를 리턴하는 메소드
          String sql = "select count(*) from t_notice_list " + where;
          int rcnt = jdbc.queryForObject(sql, Integer.class);
          return rcnt;
       }
    public List<NoticeList> getNoticeList(String where, int cpage, int psize) {
       // 게시글의 목록을  FreeList형 인스턴스로 저장한 List로 리턴하는 메소드
          
          String sql = "select nl_idx, nl_title, nl_writer, nl_read, " + 
                "if(curdate() = date(nl_date), right(nl_date, 8), " + 
                "mid(nl_date, 3, 8)) wdate from t_notice_list " + where + 
                " order by nl_idx desc limit " + ((cpage - 1) * psize) + ", " + psize;
//          System.out.println(sql);
          List<NoticeList> noticeList = jdbc.query(sql,  (ResultSet rs, int rowNum) -> {
             NoticeList nl = new NoticeList();
             nl.setNl_idx(rs.getInt("nl_idx"));
             nl.setNl_read(rs.getInt("nl_read"));
             nl.setNl_writer(rs.getString("nl_writer"));
             nl.setNl_date(rs.getString("wdate").replace("-", "."));
             
             String title = ""; int cnt = 30;
          
             if (rs.getString("nl_title").length() > cnt)
                title = rs.getString("nl_title").substring(0, cnt - 3) + "..." + title;
             else 
                title = rs.getString("nl_title") + title;
             nl.setNl_title(title);
             
             return nl;
          });
          
          return noticeList;
       }
    public int readUpdate(int nlidx) {
      // 지정한 게시글의 조회수를 1증가 시키는 매소드
      String sql = "update t_notice_list set nl_read = nl_read + 1 where nl_idx = " + nlidx;
      int result = jdbc.update(sql);
      return result;
   }

    public NoticeList getNoticeInfo(int nlidx) {
       readUpdate(nlidx);   // 조회수 증간

       String sql = "select * from t_notice_list " + " where nl_isview = 'y' and nl_idx = " + nlidx;
      NoticeList nl = jdbc.queryForObject(sql, 
         new RowMapper<NoticeList>() {
         @Override
         public NoticeList mapRow(ResultSet rs, int rowNum) throws SQLException {
            NoticeList nl = new NoticeList();
              nl.setNl_idx(rs.getInt("nl_idx"));
              nl.setNl_writer(rs.getString("nl_writer"));
               nl.setNl_title(rs.getString("nl_title"));
               nl.setNl_content(rs.getString("nl_content").replace("\r\n", "<br />"));
               nl.setNl_read(rs.getInt("nl_read"));
               nl.setNl_isview(rs.getString("nl_isview"));
               nl.setNl_date(rs.getString("nl_date"));
               nl.setNl_name(rs.getString("nl_name"));
               return nl;
         }
      });
      return nl;
   }
  
   public int noticeInsert(NoticeList nl) {
      String sql = "insert into t_notice_list (nl_writer, nl_title, nl_content, nl_name) values ('" + nl.getNl_writer() + "'," +
   " '" + nl.getNl_title() + "','" + nl.getNl_content() + "','" + nl.getNl_name() + "')";
      // System.out.println(sql);
      int result = jdbc.update(sql);   
       return result;

   }

     public int noticeUpdate(NoticeList nl) {
           String sql = "update t_notice_list set " +
                      "nl_title = ?, " +
                      "nl_name = ?, " +
                      "nl_content = ? " +
                      "where nl_idx = ?";

              int result = jdbc.update(sql, nl.getNl_title(), nl.getNl_name(), nl.getNl_content(), nl.getNl_idx());

              return result;
      }
     /*
     public int noticedelete(int nl_idx) {
          String sql = "DELETE FROM t_notice_list WHERE nl_idx = " + nl_idx;
          System.out.println("Delete SQL: " + sql);

          int result = jdbc.update(sql);
          return result;
      }*/
}