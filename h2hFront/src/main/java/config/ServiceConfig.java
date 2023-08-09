package config;

import org.apache.tomcat.jdbc.pool.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.context.annotation.*;
import ctrl.*;
import dao.*;
import svc.*;

@Configuration
public class ServiceConfig {
	
	@Autowired
	private ServiceSvc serviceSvc;
	
	@Autowired
	private ServiceChartSvc serviceChartSvc;
	
	@Autowired
	private ServiceAcceptSvc serviceAcceptSvc;
	
	@Autowired
	private ServiceRequestListSvc serviceRequestListSvc;
	
	@Bean
	   public ServiceCtrl serviceCtrl() {
	      ServiceCtrl serviceCtrl = new ServiceCtrl();
	      serviceCtrl.setServiceSvc(serviceSvc);
	      return serviceCtrl;
	   }
	
	@Bean
	public ServiceChartCtrl serviceChartCtrl() {
	ServiceChartCtrl serviceChartCtrl = new ServiceChartCtrl();
	serviceChartCtrl.setServiceChartSvc(serviceChartSvc);
	return serviceChartCtrl;
	}

	@Bean
	public ServiceAcceptCtrl serviceAcceptCtrl() {
	ServiceAcceptCtrl serviceAcceptCtrl = new ServiceAcceptCtrl();
	serviceAcceptCtrl.setServiceAcceptSvc(serviceAcceptSvc);
	return serviceAcceptCtrl;
	}

	@Bean
	public ServiceRequestListCtrl serviceRequestListCtrl() {
	ServiceRequestListCtrl serviceRequestListCtrl = new ServiceRequestListCtrl();
	serviceRequestListCtrl.setServiceRequestListSvc(serviceRequestListSvc);
	return serviceRequestListCtrl;
	}

	
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
	public ServiceRequestListDao serviceRequestListDao() {
		return new ServiceRequestListDao(DbConfig.dataSource());
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
	
	@Bean
	public ServiceRequestListSvc serviceRequestListSvc() {
		ServiceRequestListSvc serviceRequestListSvc = new ServiceRequestListSvc();
		serviceRequestListSvc.setServiceRequestListDao(serviceRequestListDao());
		return serviceRequestListSvc;
	}
}
