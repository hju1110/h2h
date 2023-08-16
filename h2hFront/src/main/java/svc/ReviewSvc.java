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
	
	 public int addReviewReply(ReviewReply rr) {

	        int result = reviewDao.addReviewReply(rr);
	        return result;
	    }
	   public List<ReviewReply> getReviewReply(int rlidx) {
	        return reviewDao.getReviewReply(rlidx);
	    }
	   public int reviewUpdate(ReviewList rl, String mi_id) {
			int result = reviewDao.reviewUpdate(rl, mi_id);
			return result;
	    }
	public void unpublishReview(int rl_idx) {
		reviewDao.unpublishReview(rl_idx);
	}
	
	
}
