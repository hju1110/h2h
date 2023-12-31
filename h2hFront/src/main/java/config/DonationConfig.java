package config;

import org.apache.tomcat.jdbc.pool.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.context.annotation.*;
import org.springframework.web.servlet.config.annotation.*;
import ctrl.*;
import dao.*;
import svc.*;

@Configuration
public class DonationConfig {
	@Autowired
	private DonationSvc donationSvc;
		
	@Bean
	public DonationCtrl donationCtrl() {
		DonationCtrl donationCtrl = new DonationCtrl();
		donationCtrl.setDonationSvc(donationSvc);
		return donationCtrl;
	}

	@Bean
	public DonationDao donationDao() {
		return new DonationDao(DbConfig.dataSource());
	}

	@Bean
	public DonationSvc donationSvc() {
		DonationSvc donationSvc = new DonationSvc();
		donationSvc.setDonationDao(donationDao());
		return donationSvc;
	}
}
