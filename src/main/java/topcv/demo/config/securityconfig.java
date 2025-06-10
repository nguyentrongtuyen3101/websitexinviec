package topcv.demo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import topcv.demo.entity.User;
import topcv.demo.service.account__service;

import java.util.Collections;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Configuration
@EnableWebSecurity
public class securityconfig {

    @Autowired
    private account__service accountService;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable()) // Tạm thời vô hiệu hóa CSRF
            .authorizeHttpRequests(auth -> auth
                .antMatchers("/account/show_form_dangky", "/account/dangky", "/account/show_form_dangnhap", "/account/dangnhap").permitAll() // Không cần đăng nhập
                .antMatchers("/admin/**").hasRole("ADMIN") // Chỉ ADMIN truy cập
                .antMatchers("/user/company/**").hasAnyRole("USER", "COMPANY") // USER hoặc COMPANY truy cập
                .anyRequest().authenticated() // Các endpoint khác yêu cầu đăng nhập
            )
            .formLogin(form -> form
                .loginPage("/account/show_form_dangnhap") // Trang đăng nhập
                .loginProcessingUrl("/account/dangnhap") // URL xử lý đăng nhập
                .successHandler(customAuthenticationSuccessHandler()) // Xử lý chuyển hướng dựa trên vai trò
                .failureUrl("/account/show_form_dangnhap?error=true") // Chuyển hướng nếu đăng nhập thất bại
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/account/logout") // URL để đăng xuất
                .logoutSuccessUrl("/account/show_form_dangnhap?logout=true") // Chuyển hướng sau khi đăng xuất
                .permitAll()
            )
            .sessionManagement(session -> session
                .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED) // Sử dụng session nếu cần
            );

        return http.build();
    }

    @Bean
    public UserDetailsService userDetailsService() {
        return username -> {
            User user = accountService.timaccountbygmail(username); // Tìm người dùng bằng email
            if (user == null) {
                throw new UsernameNotFoundException("User not found with email: " + username);
            }
            // Tạo SimpleGrantedAuthority dựa trên roleName
            SimpleGrantedAuthority authority = new SimpleGrantedAuthority("ROLE_" + user.getRoleName().name());
            return new org.springframework.security.core.userdetails.User(
                user.getEmail(), // Sử dụng email làm username
                user.getPassword(), // Mật khẩu đã mã hóa
                Collections.singleton(authority) // Vai trò
            );
        };
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(); // Sử dụng BCrypt để mã hóa và kiểm tra mật khẩu
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    @Bean
    public AuthenticationSuccessHandler customAuthenticationSuccessHandler() {
        return (request, response, authentication) -> {
            String role = authentication.getAuthorities().stream()
                .findFirst()
                .map(authority -> authority.getAuthority().replace("ROLE_", ""))
                .orElse("USER"); // Giá trị mặc định nếu không xác định được role
            if ("ADMIN".equals(role)) {
                response.sendRedirect("/admin/dashboard");
            } else if ("USER".equals(role) || "COMPANY".equals(role)) {
                response.sendRedirect("/user/company/home");
            }
        };
    }
}