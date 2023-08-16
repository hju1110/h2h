package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import javax.sql.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import vo.*;

public class ReviewDao {
	private JdbcTemplate jdbc;
	
	   public ReviewDao(DataSource dataSource) {
	        this.jdbc = new JdbcTemplate(dataSource);
	    }
	    public int getReviewListCount(String where) {
	  
	    		String sql = "select count(*) from t_review_list " + where;
	    		int rcnt = jdbc.queryForObject(sql, Integer.class);
	    		return rcnt;
	    	}
	    public List<ReviewList> getReviewList(String where, int cpage, int psize) {
   		
	    		String sql = "select rl_idx, rl_title, rl_writer, rl_read, " + 
	    				"if(curdate() = date(rl_date), right(rl_date, 8), " + 
	    				"mid(rl_date, 3, 8)) wdate from t_review_list " + where + 
	    				" order by rl_idx desc limit " + ((cpage - 1) * psize) + ", " + psize;

	    		List<ReviewList> reviewList = jdbc.query(sql,  (ResultSet rs, int rowNum) -> {
	    			ReviewList rl = new ReviewList();
	    			rl.setRl_idx(rs.getInt("rl_idx"));
	    			rl.setRl_read(rs.getInt("rl_read"));
	    			rl.setRl_writer(rs.getString("rl_writer"));
	    			rl.setRl_date(rs.getString("wdate").replace("-", "."));
	    			
	    			String title = ""; int cnt = 30;
	    			
	    			if (rs.getString("rl_title").length() > cnt)
	    				title = rs.getString("rl_title").substring(0, cnt - 3) + "..." + title;
	    			else 
	    				title = rs.getString("rl_title") + title;
	    			rl.setRl_title(title);
	    			
	    			return rl;
	    		});
	    		
	    		return reviewList;
	    	}
	    public int readUpdate(int rlidx) {

			String sql = "update t_review_list set rl_read = rl_read + 1 where rl_idx = " + rlidx;
		
			int result = jdbc.update(sql);
			return result;
		}
	    
	    public ReviewList getReviewInfo(int rlidx) {
	    	readUpdate(rlidx);

	    	String sql = "select * from t_review_list " + " where rl_isview = 'y' and rl_idx = " + rlidx;
			ReviewList rl = jdbc.queryForObject(sql, 
				new RowMapper<ReviewList>() {
				@Override
				public ReviewList mapRow(ResultSet rs, int rowNum) throws SQLException {
					ReviewList rl = new ReviewList();
			        rl.setRl_idx(rs.getInt("rl_idx"));
			        rl.setRl_writer(rs.getString("rl_writer"));
		            rl.setRl_title(rs.getString("rl_title"));
		            rl.setRl_content(rs.getString("rl_content").replace("\r\n", "<br />"));
		            rl.setRl_reply(rs.getInt("rl_reply"));
		            rl.setRl_read(rs.getInt("rl_read"));
		            rl.setRl_isview(rs.getString("rl_isview"));
		            rl.setRl_date(rs.getString("rl_date"));
		            rl.setRl_img1(rs.getString("rl_img1"));
		            rl.setRl_good(rs.getInt("rl_good"));
		            rl.setRl_origine(rs.getString("rl_origine"));
		            rl.setRl_name(rs.getString("rl_name"));
		            return rl;
				}
			});
			return rl;
	    }
	    public int reviewInsert(ReviewList rl) {
			String sql = "insert into t_review_list (rl_writer, rl_title, rl_content, rl_name) values ('" + rl.getRl_writer() + "'," +
		" '" + rl.getRl_title() + "','" + rl.getRl_content() + "','" + rl.getRl_name() + "')";
			
			int result = jdbc.update(sql);   
		    return result;

		}
	    public int addReviewReply(ReviewReply rr) {
	        String sql = "INSERT INTO t_review_reply (rl_idx, rr_writer, rr_content) VALUES (?, ?, ?)";
	        System.out.println(sql);
	        int result = jdbc.update(sql, rr.getRl_idx(), rr.getRr_writer(), rr.getRr_content());
	        return result;
	    }
	    public List<ReviewReply> getReviewReply(int rlidx) {
	        String sql = "SELECT * FROM t_review_reply WHERE rl_idx = ?";
	        List<ReviewReply> reviewReplyList = jdbc.query(sql, new Object[]{rlidx}, new RowMapper<ReviewReply>() {
	            @Override
	            public ReviewReply mapRow(ResultSet rs, int rowNum) throws SQLException {
	                ReviewReply rr = new ReviewReply();
	                rr.setRr_idx(rs.getInt("rr_idx"));
	                rr.setRl_idx(rs.getInt("rl_idx"));
	                rr.setRr_writer(rs.getString("rr_writer"));
	                rr.setRr_content(rs.getString("rr_content"));
	                rr.setRr_date(rs.getString("rr_date"));
	                return rr;
	            }
	        });

	        return reviewReplyList;
	    }
	    public int reviewUpdate(ReviewList rl, String mi_id) {
	    	 String sql = "update t_review_list set " +
	    	            "rl_title = ?, " +
	    	            "rl_name = ?, " +
	    	            "rl_content = ? " +
	    	            "where rl_idx = ? and rl_writer = ?";

	    	    int result = jdbc.update(sql, rl.getRl_title(), rl.getRl_name(), rl.getRl_content(), rl.getRl_idx(),mi_id);

	    	    return result;
		}
		public void unpublishReview(int rl_idx) {
		     String sql = "UPDATE t_review_list SET rl_isview = 'n' WHERE rl_idx = ?";
		        jdbc.update(sql, rl_idx);
		    }
	    
	    
}
