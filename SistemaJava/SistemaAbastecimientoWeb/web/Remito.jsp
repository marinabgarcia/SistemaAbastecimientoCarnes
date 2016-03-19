<%-- 
    Document   : Remito
    Created on : 4/03/2015, 10:45:10 PM
    Author     : Hamal
--%>

<%@page import="net.sf.jasperreports.engine.xml.JRXmlLoader"%>
<%@page import="net.sf.jasperreports.engine.design.JasperDesign"%>
<%@page import="org.xml.sax.InputSource"%>
<%@page import="javax.xml.xpath.XPathConstants"%>
<%@page import="javax.xml.xpath.XPathFactory"%>
<%@page import="java.util.logging.Level"%>
<%@page import="javax.xml.xpath.XPathExpressionException"%>
<%@page import="javax.xml.parsers.ParserConfigurationException"%>
<%@page import="javax.xml.xpath.XPath"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reporte iReport3.7.2</title>
    </head>
    <body>
        <h1>Realizando </h1>
        <%
            Connection conn = null;
            String url, username, password, driver;
            try {
                InputStream input = Thread.currentThread().getContextClassLoader().getResourceAsStream("config.xml");
                Document document;
                document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new InputSource(input));
                XPath xpath = XPathFactory.newInstance().newXPath();
                url = (String) xpath.compile("//config//jdbc//url").evaluate(document, XPathConstants.STRING);
                driver = (String) xpath.compile("//config//jdbc//driver").evaluate(document, XPathConstants.STRING);
                username = (String) xpath.compile("//config//jdbc//username").evaluate(document, XPathConstants.STRING);
                password = (String) xpath.compile("//config//jdbc//password").evaluate(document, XPathConstants.STRING);

                Class.forName("com.mysql.jdbc.Driver"); //se carga el driver
                conn = DriverManager.getConnection(url, username, password);

            } catch (Exception ex) {
                ex.printStackTrace();
            }
            System.setProperty("java.awt.headless", "true");
            ServletContext context = session.getServletContext();
            //File reportFile = new File(context.getRealPath("ticket.jasper"));
            //File reportFile = new File(application.getRealPath("ticket.jasper"));
            JasperDesign _des = JRXmlLoader.load(application.getRealPath("Remito.jrxml"));
             _des.setPageHeight(595);
             _des.setPageWidth(421);
            long idVenta = Long.parseLong(request.getAttribute("idVenta").toString());
            String copia=request.getAttribute("copia").toString();
            Map parameters = new HashMap();
            parameters.put("idVenta", idVenta);
            parameters.put("copia", copia);
            JasperReport _rep = JasperCompileManager.compileReport(_des);
            byte[] bytes = JasperRunManager.runReportToPdf(_rep, parameters, conn);
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream ouputStream = response.getOutputStream();
            ouputStream.write(bytes, 0, bytes.length);
            ouputStream.flush();
            ouputStream.close();

        %>
    </body>
</html>

