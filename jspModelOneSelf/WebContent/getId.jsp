<%@page import="dao.AccountDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
System.out.println("id:" + id);

AccountDao dao = AccountDao.getInstance();
boolean b = dao.getId(id); 

if(b == true){
	out.println("NO");	//해당 id 있다.
}else{
	out.println("YES"); //해당 id 없다.
}    
%>