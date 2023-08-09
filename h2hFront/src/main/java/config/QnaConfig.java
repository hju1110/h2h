package config;

import org.springframework.beans.factory.annotation.*;
import org.springframework.context.annotation.*;
import ctrl.*;
import dao.*;
import svc.*;

@Configuration
public class QnaConfig {
	@Autowired
	private QnaSvc qnaSvc;

	@Bean
	public QnaDao qnaDao() {
		return new QnaDao(DbConfig.dataSource());
	}

	@Bean
	public QnaCtrl qnaCtrl() {
		QnaCtrl qnaCtrl = new QnaCtrl();
		qnaCtrl.setQnaSvc(qnaSvc); // NoticeSvc 빈 주입
		return qnaCtrl;
	}

	@Bean
	public QnaSvc qnaSvc() {
		QnaSvc qnaSvc = new QnaSvc();
		qnaSvc.setQnaDao(qnaDao());
		return qnaSvc;
	}
}
