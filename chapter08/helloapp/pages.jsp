<%@ page contentType="text/html; charset=GB2312" %>
<%
//分页变量定义
final int e=3;            //每页显示的记录数
int totalPages=0;         //页面总数
int currentPage=1;        //当前页面编号
int totalCount=0;         //数据库中数据的总记录数
int p=1;                  //当前页面所显示的第一条记录的游标

//读取当前待显示的页面编号
String tempStr=request.getParameter("currentPage");
if(tempStr!=null && !tempStr.equals(""))
  currentPage=Integer.parseInt(tempStr);

/* 分页预备 */

//计算总记录数
rs=stmt.executeQuery("select count(*) from BOOKS;");
if(rs.next())
  totalCount=rs.getInt(1);

//计算总的页数
totalPages=((totalCount%e==0)?(totalCount/e):(totalCount/e+1));
if(totalPages==0) totalPages=1;

//修正当前页面编号，确保：1<=currentPage<=totalPages
if(currentPage>totalPages) 
  currentPage=totalPages;
else if(currentPage<1) 
  currentPage=1;

//计算当前页面所显示的第一条记录的游标
p=(currentPage-1)*e+1;

String sql="select ID,NAME,TITLE,PRICE from BOOKS order by ID limit "
                                                      +(p-1)+","+e;
rs=stmt.executeQuery(sql);

%>

<%-- 显示页标签 --%>
页码：
<% for(int i=1;i<=totalPages;i++){
     if(i==currentPage){ 
%>
       <%=i%>
<%   }else{ %>
       <a href="dbaccess2.jsp?currentPage=<%=i%>"><%=i %></a>
<%   } %>

<% } %>

&nbsp; 共<%=totalPages%>页,共<%=totalCount%>条记录


<table border="1" width=400>

<tr>
<td bgcolor="#D8E4F1"><b>书编号</b></td>
<td bgcolor="#D8E4F1"><b>作者</b></td>
<td bgcolor="#D8E4F1"><b>书名</b></td>
<td bgcolor="#D8E4F1"><b>价格</b></td>
</tr>

<%
while(rs.next()){

  String id=rs.getString(1);
  String name=rs.getString(2);
  String title=rs.getString(3);
  float price=rs.getFloat(4);
%>


<tr>
<td><%=id %></td>
<td><%=name %></td>
<td><%=title %></td>
<td><%=price %></td>
</tr>

<% 
} //#while 
%> 

</table>


