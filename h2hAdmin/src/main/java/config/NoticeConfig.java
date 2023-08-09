package config;

import org.apache.tomcat.jdbc.pool.*;
import org.springframework.context.annotation.*;

import dao.NoticeDao;
import svc.NoticeSvc;


// �쉶�썝 愿��젴 �옉�뾽 �꽕�젙 �겢�옒�뒪
@Configuration
public class NoticeConfig {
	@Bean(destroyMethod="close")
	public DataSource dataSource() {
		DataSource ds = new DataSource();
		ds.setDriverClassName("com.mysql.jdbc.Driver");
		ds.setUrl("jdbc:mysql://localhost/h2h?characterEncoding=utf-8");
		ds.setUsername("root");
		ds.setPassword("1234");
		ds.setInitialSize(2);
		ds.setMaxActive(10);
		ds.setTestWhileIdle(true);
		ds.setMinEvictableIdleTimeMillis(60000 * 3);
		ds.setTimeBetweenEvictionRunsMillis(10 * 1000);
		return ds;
	}
	
	@Bean
	public NoticeDao noticeDao() {
		return new NoticeDao(dataSource());
	}
	
	@Bean 
	public NoticeSvc noticeSvc() {
		NoticeSvc noticeSvc = new NoticeSvc();
		noticeSvc.setNoticeDao(noticeDao());
		return noticeSvc;
	}
}
