package mypack;

import javax.servlet.*;
import java.io.*;

public class HelloServlet1 extends GenericServlet {
  private String username=null;  //username为实例变量
  
  /** 响应客户请求*/
  public void service(ServletRequest request,
              ServletResponse response)
              throws ServletException, IOException {
    
    //把username请求参数赋值给username实例变量 
    username=request.getParameter("username");
    
    try{
      Thread.sleep(3000); //特意延长响应客户请求的时间
    }catch(Exception e){e.printStackTrace();}
      
    //设置HTTP响应的正文的MIME类型及字符编码
    response.setContentType("text/html;charset=GBK");
   
    /*输出HTML文档*/
    PrintWriter out = response.getWriter();
    out.println("<html><head><title>HelloServlet</TITLE></head>");
    out.println("<body>");
    out.println("你好: "+username);
    out.println("</body></html>");
     
    out.close(); //关闭PrintWriter
   }
}




/****************************************************
 * 作者：孙卫琴                                     *
 * 来源：<<Tomcat与Java Web开发技术详解>>           *
 * 技术支持网址：www.javathinker.net                *
 ***************************************************/
