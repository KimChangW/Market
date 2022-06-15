package market.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AjaxLoginCheck extends HandlerInterceptorAdapter {
	static final Logger logger = LoggerFactory.getLogger(AjaxLoginCheck.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("pre handle...");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String requestUrl = request.getRequestURL().toString();
		boolean result = false;

		String id = (String) session.getAttribute("m_email");
		// 로그인 경로 제외
		if (requestUrl.contains("loginForm.do")) {
			return true;
		}

		// 리소스 경로 제외
		if (requestUrl.contains("/resources")) {
			return true;
		}

		if (id == null || id.equals("")) {

//			if(isAjaxRequest(request)) {
//				response.sendError(500);
//				return false;
//			}else {
//				response.sendRedirect("loginForm.do");
//			}
			out.print("<script> alert('로그인이 필요한 서비스입니다.');</script>");
			out.print("<script> location.href='loginForm.do'; </script>");
			out.close();
			
			// response.sendRedirect("loginForm.do"); // 세션이 없으면 로그인 폼으로 이동
		
		}

		
		
		
		return true;
	}

//	private boolean isAjaxRequest(HttpServletRequest req) {
//		// TODO Auto-generated method stub
//		String header = req.getHeader("AJAX");
//		if("true".equals(header)) {
//			return true;
//		}else {
//			return false;
//		}
		
//	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		logger.info("post handle...");
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
