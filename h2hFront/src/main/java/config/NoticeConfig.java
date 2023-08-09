package config;

import org.springframework.beans.factory.annotation.*;
import org.springframework.context.annotation.*;
import dao.*;
import svc.*;
import ctrl.*;

// �쉶�썝 愿��젴 �옉�뾽 �꽕�젙 �겢�옒�뒪
@Configuration
public class NoticeConfig {
	@Autowired
	private NoticeSvc noticeSvc;

	@Bean
	public NoticeListCtrl noticeListCtrl() {
		NoticeListCtrl noticeListCtrl = new NoticeListCtrl();
		noticeListCtrl.setNoticeSvc(noticeSvc); // NoticeSvc 빈 주입
		return noticeListCtrl;
	}

	@Bean
	public NoticeDao noticeDao() {
		return new NoticeDao(DbConfig.dataSource());
	}

	@Bean
	public NoticeSvc noticeSvc() {
		NoticeSvc noticeSvc = new NoticeSvc();
		noticeSvc.setNoticeDao(noticeDao());
		return noticeSvc;
	}
}
