package svc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import dao.*;
import vo.*;

@Service
public class ReviewSvc {
	private ReviewDao reviewDao;
	
	public void setReviewDao(ReviewDao reviewDao) {
		this.reviewDao = reviewDao;
	}
	public List<ReviewList> getReviewList(String where, int cpage, int psize) {
		List<ReviewList> reviewList = reviewDao.getReviewList(where, cpage, psize);
		return reviewList;
	}

	public int getReviewListCount(String where) {
		int rcnt = reviewDao.getReviewListCount(where);
		return rcnt;
	}
	public ReviewList getReviewInfo(int rlidx) {
		ReviewList rl = reviewDao.getReviewInfo(rlidx);
		return rl;
	}
	public int reviewInsert(ReviewList rl) {
		int result = reviewDao.reviewInsert(rl);
		return result;
	}
	
	 /*public String getImagePath(String filename) {
	        // 이미지 파일이 저장된 디렉토리 경로를 기준으로 이미지 파일의 전체 경로를 생성합니다.
	        String imagePath = uploadPath2 + "/" + filename;
	        // 생성된 이미지 파일 경로를 반환합니다.
	        return imagePath;
	    }*/
	 public int addReviewReply(ReviewReply rr) {
	        // 댓글 등록 처리를 수행하는 메서드
	        int result = reviewDao.addReviewReply(rr);
	        return result;
	    }
	   public List<ReviewReply> getReviewReply(int rlidx) {
	        return reviewDao.getReviewReply(rlidx);
	    }
	   public int reviewUpdate(ReviewList rl) {
			int result = reviewDao.reviewUpdate(rl);
			return result;
		
	   /* } 
	   public List<ReviewReply> getReviewCommentCount() {
	        List<ReviewReply> reviewList = reviewDao.getReviewList();
	        for (ReviewReply review : reviewList) {
	            int commentCount = reviewDao.getReviewCommentCount(review.getRl_idx());
	            review.setCount(commentCount);
	        }
	        return reviewList;
	        */
	    }
	
}
