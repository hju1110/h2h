package config;

import org.springframework.context.annotation.*;
import org.springframework.web.servlet.config.annotation.*;

@Configuration
@EnableWebMvc
public class MvcConfig implements WebMvcConfigurer {	// 설정 클래스
	public void configureDefaultSerbletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}
	
	public void configureViewResolvers(ViewResolverRegistry registry) {
		registry.jsp("/WEB-INF/view/", ".jsp");	// view 파일들의 기본 위치와 확장자를 지정
	}
	
	// 단순히 이동만 하는 경우 컨트롤러를 따로 생성하지 않고 요청 경로와 뷰 이름을 연결시주는 메소드
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("index");
	}
}
