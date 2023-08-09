package config;

import org.apache.tomcat.jdbc.pool.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.*;

import ctrl.ScheduleCtrl;
import dao.*;
import svc.*;

// 일정 관리 관련 작업 설정 클래스
@Configuration
public class ScheduleConfig {
	
	@Bean
	public ScheduleDao scheduleDao() {
		return new ScheduleDao(DbConfig.dataSource());
	}
	
	@Bean
	public ScheduleSvc scheduleSvc() {
		ScheduleSvc scheduleSvc = new ScheduleSvc();
		scheduleSvc.setScheduleDao(scheduleDao());;
		return scheduleSvc;
	}
}
