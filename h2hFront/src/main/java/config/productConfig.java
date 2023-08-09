package config;

import org.apache.tomcat.jdbc.pool.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.context.annotation.*;
import dao.*;
import svc.*;
import ctrl.*;

@Configuration
public class productConfig {

	@Autowired
	private OrderProcSvc orderProcSvc;

	@Autowired
	private ParcelProcSvc parcelProcSvc;
	
	@Autowired
	private ProductProcSvc productProcSvc;
	

	@Bean
	public OrderCtrl orderCtrl() {
		OrderCtrl orderCtrl = new OrderCtrl();
		orderCtrl.setOrderProcSvc(orderProcSvc);
		return orderCtrl;
	}

	@Bean
	public ParcelProcCtrl parcelProcCtrl() {
		ParcelProcCtrl parcelProcCtrl = new ParcelProcCtrl();
		parcelProcCtrl.setParcelProcSvc(parcelProcSvc);
		return parcelProcCtrl;
	}
	
	@Bean
	public ProductCtrl productCtrl() {
		ProductCtrl productCtrl = new ProductCtrl();
		productCtrl.setProductProcSvc(productProcSvc);
		return productCtrl;
	}

	@Bean
	public ProductProcDao productProcDao() {
		return new ProductProcDao(DbConfig.dataSource());
	}

	@Bean
	public ProductProcSvc productProcSvc() {
		ProductProcSvc productProcSvc = new ProductProcSvc();
		productProcSvc.setProductProcDao(productProcDao());
		return productProcSvc;
	}

	@Bean
	public OrderProcDao orderProcDao() {
		return new OrderProcDao(DbConfig.dataSource());
	}

	@Bean
	public OrderProcSvc orderProcSvc() {
		OrderProcSvc orderProcSvc = new OrderProcSvc();
		orderProcSvc.setOrderProcDao(orderProcDao());
		return orderProcSvc;
	}

	@Bean
	public ParcelProcDao parcelProcDao() {
		return new ParcelProcDao(DbConfig.dataSource());
	}

	@Bean
	public ParcelProcSvc parcelProcSvc() {
		ParcelProcSvc parcelProcSvc = new ParcelProcSvc();
		parcelProcSvc.setParcelProcDao(parcelProcDao());
		return parcelProcSvc;
	}
}
