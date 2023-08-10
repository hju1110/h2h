package config;

import org.apache.tomcat.jdbc.pool.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.context.annotation.*;
import ctrl.*;
import dao.*;
import svc.*;

@Configuration
public class ServiceConfig {
		
	@Bean
	public ServiceDao serviceDao() {
		return new ServiceDao(DbConfig.dataSource());
	}
	
	
	@Bean
	public ServiceSvc serviceSvc() {
		ServiceSvc serviceSvc = new ServiceSvc();
		serviceSvc.setServiceDao(serviceDao());
		return serviceSvc;
	}
	
}
