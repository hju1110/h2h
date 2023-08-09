package config;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import dao.QnaDao;
import svc.QnaSvc;

@Configuration
public class QnaConfig {
	
    @Bean(destroyMethod = "close")
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
    public QnaDao qnaDao() {
        return new QnaDao(dataSource());
    }

    @Bean
    public QnaSvc qnaSvc() {
        QnaSvc qnaSvc = new QnaSvc();
        qnaSvc.setQnaDao(qnaDao());
        return qnaSvc;
    }
}
