/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.37
 * Generated at: 2021-03-22 08:21:15 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import dao.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.time.Period;

public final class updatingTasks_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("java.sql");
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("dao");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("java.time.Period");
    _jspx_imports_classes.add("java.text.SimpleDateFormat");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!--\r\n");
      out.write("\r\n");
      out.write("updatingTasks.jsp\r\n");
      out.write("\r\n");
      out.write("java version \"1.8.0_45\"\r\n");
      out.write("\r\n");
      out.write("Created By Dhanush L\r\n");
      out.write("                 \r\n");
      out.write("-->\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<title>To-Do</title>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\t");

	    JDBC_List_Operations jdbc = new JDBC_List_Operations();
		JDBC_List_Flags_Operations jdbcFlags = new JDBC_List_Flags_Operations();
		JDBC_List_SubTasks_Operations jdbcSubTasks = new JDBC_List_SubTasks_Operations();
		JDBC_List_Dates_Operations jdbcDates = new JDBC_List_Dates_Operations();
		
		int userId = Integer.parseInt(request.getParameter("userId")) , taskId=-1, taskStatus=-1, importantFlag=0, flaggedFlag=0;
		String description="", repeat=null, subTasks="", category="";
		String[] temp={};
		java.sql.Date remainder=null, dueDate=null;
		
		if(!request.getParameter("taskNameF").equals("")){
			taskId = Integer.parseInt(request.getParameter("taskId"));
			try{
				if(request.getParameter("taskStatus").equals("on"))
					taskStatus=1;
					
			}catch(Exception e){
				taskStatus=0;
			}
			try{
				if(request.getParameter("importantFlag").equals("on"))
					importantFlag=1;
			}catch(Exception e){
				importantFlag=0;
			}
			try{
				if(request.getParameter("flaggedFlag").equals("on"))
					flaggedFlag=1;
			}catch(Exception e){
				flaggedFlag=0;
			}
			if(!request.getParameter("descriptionF").equals("")){
				String noSpace = request.getParameter("descriptionF").trim();
				noSpace = noSpace.replaceAll(" +"," ");
				description += noSpace;
			}
			
			//Status and Description Update
			jdbc.updateTaskDetails(taskId, description, taskStatus, importantFlag, flaggedFlag); 
			
			int flag=0;
			if(!request.getParameter("category").equals("")){
				
				String noSpace = request.getParameter("category").trim();
				noSpace = noSpace.replaceAll(" +"," ");
				noSpace = noSpace.replaceAll("[^A-Za-z0-9 ]","");
		        
				if(noSpace.length()>0){
					temp = noSpace.split("\\s+");
					if(temp.length>0){
						for(String i:temp){
							category += i+",";
						}
						flag++;
					}
				}
			}
			
			//Flags Operations
			if(!jdbcFlags.isCheck_Task_Id(taskId)){
				if(flag!=0)
					jdbcFlags.insertFlagRecord(taskId, category);
			}else{
				if(flag!=0){
					jdbcFlags.updateFlagRecord(taskId, category);
				}else{
					jdbcFlags.deleteFlagRecord(taskId);
				}
			}
			
			flag=0;
			if(!request.getParameter("subTasks").equals("")){
				
				String noSpace = request.getParameter("subTasks").trim();
				noSpace = noSpace.replaceAll(" +"," ");
				noSpace = noSpace.replaceAll("[^A-Za-z0-9 ]","");
				
				if(noSpace.length()>0){
					temp = noSpace.split("\\s+");
					if(temp.length>0){
						for(String i:temp){
							subTasks += i+",";
						}
						flag++;
					}
				}
			}
			
			//SubTasks Operations
			if(!jdbcSubTasks.isCheck_Task_Id(taskId)){
				if(flag!=0)
					jdbcSubTasks.insertSubTaskRecord(taskId, subTasks);
			}else{
				if(flag!=0)
					jdbcSubTasks.updateSubTaskRecord(taskId, subTasks);
				else
					jdbcSubTasks.deleteSubTaskRecord(taskId);
			}
			
			flag=0;
			if(!request.getParameter("repeat").equals("")){
				
				String noSpace = request.getParameter("repeat").trim();
				noSpace = noSpace.replaceAll(" +"," ");
				noSpace = noSpace.replaceAll("[^A-Za-z0-9 ]","");
				
				if(noSpace.length()>0){
					repeat="";
					repeat += noSpace;
					flag++;
				}
			}
			if(!request.getParameter("remainder").equals("")){
				SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
				java.util.Date date = sdf1.parse(request.getParameter("remainder"));
				remainder = new java.sql.Date(date.getTime());
				flag++;
			}
			if(!request.getParameter("dueDate").equals("")){
				SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
				java.util.Date date = sdf1.parse(request.getParameter("dueDate"));
				dueDate = new java.sql.Date(date.getTime()); 
				flag++;
			}
			
			//Task Dates Operations
			if(!jdbcDates.isCheck_Task_Id(taskId)){
				if(flag!=0)
					jdbcDates.insertDatesRecord(taskId, dueDate, repeat, remainder);
			}else{
				if(flag!=0)
					jdbcDates.updateDatesRecord(taskId, dueDate, repeat, remainder);
				else
					jdbcDates.deleteDatesRecord(taskId);
			}
		}
		
		int pageId = Integer.parseInt(request.getParameter("pageId"));
		
		if(pageId==0)
			response.sendRedirect("UserTaskList.jsp");
		else if(pageId==1)
			response.sendRedirect("importantTaskList.jsp");
		else if(pageId==2)
			response.sendRedirect("flaggedTaskList.jsp");
		else if(pageId==3)
			response.sendRedirect("PlannedTaskList.jsp");
		else if(pageId==4)
			response.sendRedirect("NeedAttentionTasks.jsp");
	
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
