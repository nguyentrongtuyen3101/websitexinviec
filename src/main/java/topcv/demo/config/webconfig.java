package topcv.demo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import javax.servlet.Filter;
import javax.servlet.ServletContext;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Properties;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "topcv.demo")
public class webconfig extends AbstractAnnotationConfigDispatcherServletInitializer implements WebMvcConfigurer {

	@Autowired
    private ServletContext servletContext;
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class<?>[]{dataconfig.class};
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class<?>[]{webconfig.class};
    }

    @Override
    protected String[] getServletMappings() {
        return new String[]{"/"};
    }

    @Override
    protected Filter[] getServletFilters() {
        CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
        characterEncodingFilter.setEncoding("UTF-8");
        characterEncodingFilter.setForceEncoding(true);
        return new Filter[]{characterEncodingFilter};
    }

    @Override
    protected String getServletName() {
        return "dispatcher";
    }

    @Override
    protected boolean isAsyncSupported() {
        return true;
    }

    @Bean
    public CharacterEncodingFilter characterEncodingFilter() {
        CharacterEncodingFilter filter = new CharacterEncodingFilter();
        filter.setEncoding("UTF-8");
        filter.setForceEncoding(true);
        return filter;
    }

    @Bean
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setMaxUploadSize(10485760); // 10MB
        resolver.setDefaultEncoding("UTF-8");
        return resolver;
    }

    @Bean
    public JavaMailSender mailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost("smtp.gmail.com");
        mailSender.setPort(587);
        mailSender.setUsername("tinhluc2@gmail.com");
        mailSender.setPassword("axqnsafslczyhcuy");

        Properties props = mailSender.getJavaMailProperties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        return mailSender;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        try {
            // Sử dụng ServletContext để lấy đường dẫn thực tế
            String realPath = servletContext.getRealPath("/uploads");
            Path uploadPath = Paths.get(realPath);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
                System.out.println("Created uploads directory at: " + uploadPath.toAbsolutePath().toString());
            }
        } catch (Exception e) {
            System.err.println("Failed to create uploads directory: " + e.getMessage());
        }

        registry.addResourceHandler("/resources/**")
                .addResourceLocations("file:src/main/webapp/resources/", "/resources/")
                .setCachePeriod(0);
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:" + servletContext.getRealPath("/uploads") + "/")
                .setCachePeriod(0);
    }

    @Bean
    public InternalResourceViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setViewClass(JstlView.class);
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        return resolver;
    }
}