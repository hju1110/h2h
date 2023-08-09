package config;

import org.apache.tomcat.jdbc.pool.*;
import org.springframework.context.annotation.*;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.jdbc.datasource.*;		 // 트랜잭션 추가
import org.springframework.transaction.*;			 // 트랜잭션 추가
import org.springframework.transaction.annotation.*; // 트랜잭션 추가
import dao.*;
import svc.*;

@Configuration
@EnableTransactionManagement
public class productConfig {
	
	@Bean(destroyMethod = "close")
	public DataSource dataSource() {
		DataSource ds = new DataSource();
		ds.setDriverClassName("com.mysql.jdbc.Driver");
		ds.setUrl("jdbc:mysql://localhost/h2h?characterEncoding=utf8");
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
	public PlatformTransactionManager transactionManager() {
		DataSourceTransactionManager tm = new DataSourceTransactionManager();
		tm.setDataSource(dataSource());
		return tm;
	}
	
	@Bean
	public ProductProcDao productProcDao() {
		return new ProductProcDao(dataSource());
	}

	@Bean
	public ProductProcSvc productProcSvc() {
		ProductProcSvc productProcSvc = new ProductProcSvc();
		productProcSvc.setProductProcDao(productProcDao());
		return productProcSvc;
	}
	
	@Bean
	public OrderProcDao orderProcDao() {
		return new OrderProcDao(dataSource());
	}

	@Bean
	public OrderProcSvc orderProcSvc() {
		OrderProcSvc orderProcSvc = new OrderProcSvc();
		orderProcSvc.setOrderProcDao(orderProcDao());
		return orderProcSvc;
	}
	
	@Bean
	public ParcelProcDao parcelProcDao() {
		return new ParcelProcDao(dataSource());
	}

	@Bean
	public ParcelProcSvc parcelProcSvc() {
		ParcelProcSvc parcelProcSvc = new ParcelProcSvc();
		parcelProcSvc.setParcelProcDao(parcelProcDao());
		return parcelProcSvc;
	}
}
