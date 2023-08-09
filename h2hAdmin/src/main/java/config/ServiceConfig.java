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
	public ServiceChartDao serviceChartDao() {
		return new ServiceChartDao(DbConfig.dataSource());
	}
	
	@Bean
	public ServiceAcceptDao serviceAcceptDao() {
		return new ServiceAcceptDao(DbConfig.dataSource());
	}
	
	
	@Bean
	public ServiceSvc serviceSvc() {
		ServiceSvc serviceSvc = new ServiceSvc();
		serviceSvc.setServiceDao(serviceDao());
		return serviceSvc;
	}
	
	@Bean
	public ServiceChartSvc serviceChartSvc() {
		ServiceChartSvc serviceChartSvc = new ServiceChartSvc();
		serviceChartSvc.setServiceChartDao(serviceChartDao());
		return serviceChartSvc;
	}
	
	@Bean
	public ServiceAcceptSvc serviceAcceptSvc() {
		ServiceAcceptSvc serviceAcceptSvc = new ServiceAcceptSvc();
		serviceAcceptSvc.setServiceAcceptDao(serviceAcceptDao());
		return serviceAcceptSvc;
	}
}
