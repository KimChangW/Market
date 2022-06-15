package market.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class ShopLoginCheck extends HandlerInterceptorAdapter {
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String requestUrl = request.getRequestURL().toString();

		String shopid = (String) session.getAttribute("s_email");
		// 로그인 경로 제외
		if (requestUrl.contains("shop_login_form.do")) {
			return true;
		}

		// 리소스 경로 제외
		if (requestUrl.contains("/resources")) {
			return true;
		}

		
		if (shopid == null || shopid.equals("")) {
			out.print("<script> alert('로그인이 필요한 서비스입니다.');</script>");
			out.print("<script> location.href='shop_login_form.do'; </script>");
			out.close();
			
			return false;
		}
		
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}
}
