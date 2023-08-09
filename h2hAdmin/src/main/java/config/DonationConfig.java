package config;

import org.springframework.context.annotation.*;
import ctrl.*;
import dao.*;
import svc.*;

@Configuration
public class DonationConfig {
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
