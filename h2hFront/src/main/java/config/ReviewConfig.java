package config;

import org.springframework.beans.factory.annotation.*;
import org.springframework.context.annotation.*;
import dao.*;
import svc.*;
import ctrl.*;

@Configuration
public class ReviewConfig {
	@Autowired
	private ReviewSvc reviewSvc;

	@Bean
	public ReviewCtrl reviewCtrl() {
		ReviewCtrl reviewCtrl = new ReviewCtrl();
		reviewCtrl.setReviewSvc(reviewSvc); // NoticeSvc 빈 주입
		return reviewCtrl;
	}

	@Bean
	public ReviewDao reviewDao() {
		return new ReviewDao(DbConfig.dataSource());
	}

	@Bean
	public ReviewSvc reviewSvc() {
		ReviewSvc reviewSvc = new ReviewSvc();
		reviewSvc.setReviewDao(reviewDao());
		return reviewSvc;
	}
}
