package com.samarth.CRUDAPP.Filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/students")
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse response1 =(HttpServletResponse) response;
        HttpServletRequest request1 = (HttpServletRequest) request;

        HttpSession session = request1.getSession(false);

        if(session == null || session.getAttribute("user")==null){
            response1.sendRedirect("user");
            return;
        }

        chain.doFilter(request,response);
    }
}
