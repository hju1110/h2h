package dao;

import static db.JdbcUtil.*;	// JdbcUtil 클래스의 모든 멤버들을 자유롭게 사용(마치 상속받듯이)
import java.util.*;
import java.sql.*;
import vo.*;

public class FreeReplyProcDao {
	private static FreeReplyProcDao freeReplyProcDao;
	private Connection conn;
	private FreeReplyProcDao() {}		
	
	public static FreeReplyProcDao getInstance() {
		if (freeReplyProcDao == null) freeReplyProcDao = new FreeReplyProcDao();
		return freeReplyProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public ArrayList<FreeReply> getReplyList(int flidx) {
	// 지정한 게시글에 속하는 댓글들의 목록을  ArrayList<FreeReply>형으로 리턴하는 메소드 
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<FreeReply> replyList = new ArrayList<FreeReply>();	
		// 댓글들의 목록을 저장한 ArrayList 객체
		FreeReply freeReply = null; 
		// replyList에 저장할 하나의 댓글 정보를 담을 인스턴스 
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_free_reply where fr_isview = 'y' and fl_idx = " + flidx;
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {	//while을 쓰는 이유는 rs값이 있는지 없는지 별로 궁금하지 않아서 
				freeReply = new FreeReply();
				//하나의 댓글 정보들을 저장할 FreeReply 형 인스턴스 생성 
				
				freeReply.setFr_idx(rs.getInt("fr_idx"));
				freeReply.setFl_idx(flidx);
				freeReply.setMi_id(rs.getString("mi_id"));
				freeReply.setFr_content(rs.getString("fr_content"));
				freeReply.setFr_good(rs.getInt("fr_good"));
				freeReply.setFr_bad(rs.getInt("fr_bad"));
				freeReply.setFr_ip(rs.getString("fr_ip"));
				freeReply.setFr_date(rs.getString("fr_date"));
				replyList.add(freeReply);
			}
			
		} catch(Exception e) {
			System.out.println("FreeReplyProcDao 클래스의 getFreeReplyList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}	
		
		
		return replyList;
	}

	public int replyInsert(FreeReply freeReply) {
	// 사용자가 입력한 댓글을 테이블에 저장 시키는 메소드 
		int result = 0;
		PreparedStatement pstmt = null;
		Statement stmt = null;
		
		try {
			String sql = "insert into t_free_reply (fl_idx, mi_id, fr_content, fr_ip) values (?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, freeReply.getFl_idx());		pstmt.setString(2, freeReply.getMi_id());
			pstmt.setString(3, freeReply.getFr_content());	pstmt.setString(4, freeReply.getFr_ip());
			result = pstmt.executeUpdate();	//댓글 등록 
			
			stmt = conn.createStatement();//db생성
			sql = "update t_free_list set fl_reply = fl_reply + 1 where fl_idx = " + freeReply.getFl_idx();
			stmt.executeUpdate(sql);		// 댓글 개수 증가 쿼리 실행 
			
		}catch(Exception e) {
			System.out.println("FreeReplyProcDao 클래스의 replyInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(pstmt); close(stmt);
		}		
		
		return result;
	}

	public int replyGnb(FreeReplyGnb freeReplyGnb) {
	// 지정한 댓글에 좋아요/ 싫어요를 처리하는 메소드
	// 이미 참여했던 댓글일 경우 -1, 정상 처리 됐으면 2를 처리가 안됐으면 0이나 1 리턴 
		int result = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select frg_gnb from t_free_reply_gnb where mi_id = '" + freeReplyGnb.getMi_id() + "' and fr_idx = " 
			+ freeReplyGnb.getFr_idx();
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {		// 이미 좋아요 싫어요에 참여 했으면
				result = -1;
			} else {
				sql = "update t_free_reply set fr_" + freeReplyGnb.getFrg_gnb() + 
				" = fr_"+ freeReplyGnb.getFrg_gnb() + " + 1 where fr_idx = " + freeReplyGnb.getFr_idx();
				result = stmt.executeUpdate(sql);
				// 댓글에 좋아요/싫어요 개수 추가 쿼리 실행 
				
				sql = "insert into t_free_reply_gnb (mi_id,fr_idx,frg_gnb) value ('" + freeReplyGnb.getMi_id() + 
				"', " + freeReplyGnb.getFr_idx() + ", '" + freeReplyGnb.getFrg_gnb().charAt(0) + "')";
				result += stmt.executeUpdate(sql);
				//좋아요/싫어요 개수 추가 쿼리 실행 
			}
			
		} catch(Exception e) {
			System.out.println("FreeReplyProcDao 클래스의 replyGnb() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}
		
		return result;
	}

	public int replyDel(FreeReply freeReply) {
	// 사용자가 지정한 댓글을 삭제 시키는 메소드
		int result = 0;
		Statement stmt = null;
			
		try {
			stmt = conn.createStatement();
			String sql = "update t_free_reply set fr_isview = 'n' where mi_id = '" + freeReply.getMi_id() + "' and fr_idx = " 
			+ freeReply.getFr_idx();
			//System.out.println(sql); 
			result = stmt.executeUpdate(sql);
			
			sql = "update t_free_list set fl_reply = fl_reply - 1 where fl_idx = " + freeReply.getFl_idx();
			//System.out.println(sql); 					 
			result += stmt.executeUpdate(sql);
						
		} catch(Exception e) {
			System.out.println("FreeReplyProcDao 클래스의 replyDel() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}	
		
		return result;
	}
}
