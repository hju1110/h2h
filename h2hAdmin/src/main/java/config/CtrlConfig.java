package config;

import org.apache.tomcat.jdbc.pool.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.*;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import ctrl.*;
import svc.*;
import dao.*;


@Configuration
public class CtrlConfig {
	@Autowired
	private ProductProcSvc productProcSvc;
	
	@Autowired
	private OrderProcSvc orderProcSvc;
	
	@Autowired
	private ParcelProcSvc parcelProcSvc;
	
	@Autowired
	private LoginSvc loginSvc;
	
	@Autowired
	private MemberInfoSvc memberInfoSvc;
	
	@Autowired
	private DonationSvc donationSvc;
	
	@Autowired
	private ScheduleSvc scheduleSvc;
	
	@Autowired
	private ServiceSvc serviceSvc;

	@Autowired
	private NoticeSvc noticeSvc;

	@Autowired
	private ReviewSvc reviewSvc;

	@Autowired
	private QnaSvc qnaSvc;
	
	@Bean
	public IndexCtrl indexCtrl() {
		return new IndexCtrl();
	}

	@Bean
	public ProductCtrl productCtrl() {
		ProductCtrl productCtrl = new ProductCtrl();
		productCtrl.setProductProcSvc(productProcSvc);
		return productCtrl;
	}
	
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
	public LoginCtrl loginCtrl() {
		LoginCtrl loginCtrl = new LoginCtrl();
		loginCtrl.setLoginSvc(loginSvc);
		return loginCtrl;
	}
	
	@Bean
	public LogoutCtrl logoutCtrl() {
		return new LogoutCtrl();
	}
	
	@Bean
	public MemberInfoCtrl memberInfoCtrl() {
		MemberInfoCtrl memberInfoCtrl = new MemberInfoCtrl();
		memberInfoCtrl.setMemberInfoSvc(memberInfoSvc);
		return memberInfoCtrl;
	}
	
	@Bean
	public DonationCtrl donationCtrl() {
		DonationCtrl donationCtrl = new DonationCtrl();
		donationCtrl.setDonationSvc(donationSvc);
		return donationCtrl;
	}
	
	@Bean
	public ScheduleCtrl scheduleCtrl() {
		ScheduleCtrl scheduleCtrl = new ScheduleCtrl();
		scheduleCtrl.setScheduleSvc(scheduleSvc);
		return scheduleCtrl;
	}
	
	@Bean
	public ServiceCtrl serviceCtrl() {
		ServiceCtrl serviceCtrl = new ServiceCtrl();
		serviceCtrl.setServiceSvc(serviceSvc);
		return serviceCtrl;
	}
	
    @Bean
    public NoticeListCtrl noticeListCtrl() {
        NoticeListCtrl noticeListCtrl = new NoticeListCtrl();
        noticeListCtrl.setNoticeSvc(noticeSvc); // NoticeSvc 빈 주입
        return noticeListCtrl;
    }
    @Bean
    public ReviewCtrl reviewCtrl() {
        ReviewCtrl reviewCtrl = new ReviewCtrl();
        reviewCtrl.setReviewSvc(reviewSvc); // NoticeSvc 빈 주입
        return reviewCtrl;
    }
    @Bean
    public QnaCtrl qnaCtrl() {
        QnaCtrl qnaCtrl = new QnaCtrl();
        qnaCtrl.setQnaSvc(qnaSvc); // NoticeSvc 빈 주입
        return qnaCtrl;
    }

}
