<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>
<jsp:useBean id="mud" scope="session" class="mypack.MailUserData"/>

<%!
private Properties props=null;
public void jspInit() {
  props = System.getProperties();
  props.put("mail.transport.protocol", "smtp");
  props.put("mail.store.protocol", "imap");
  props.put("mail.smtp.class", "com.sun.mail.smtp.SMTPTransport");
  props.put("mail.imap.class", "com.sun.mail.imap.IMAPStore");
  props.put("mail.smtp.host", "localhost");
}
%>

<%
String hostname = request.getParameter("hostname");
String username = request.getParameter("username");
String password = request.getParameter("password");

//创建Mail Session对象
Session mailsession = Session.getDefaultInstance(props, null);

//创建Store对象
Store store = mailsession.getStore("imap");

try{
  //连接邮件服务器
  store.connect(hostname,username, password);
}catch(Exception e){
  request.setAttribute("loginfail","true");
%>
  <jsp:forward page="login.jsp" />
<%
}
%>

<%
// 在MailUserData对象中保存Mail Session对象和Store对象
mud.setSession(mailsession);
mud.setStore(store);
//创建并打开默认的Trash、Draft和sendbox邮件夹
Folder folder=store.getFolder("Trash");
if(!folder.exists())folder.create(Folder.HOLDS_MESSAGES);

folder=store.getFolder("SendBox");
if(!folder.exists())folder.create(Folder.HOLDS_MESSAGES);

folder=store.getFolder("Draft");
if(!folder.exists())folder.create(Folder.HOLDS_MESSAGES);

folder.open(Folder.READ_WRITE);

//把URL保存到MailUserData对象中
URLName url = new URLName("imap",hostname, -1, "inbox", username, password);
mud.setURLName(url);

%>

<jsp:forward page="listallfolders.jsp" />