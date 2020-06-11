<%-- 
    Document   : informe
    Created on : 01-jun-2020, 22:06:31
    Author     : Oscar Durán
--%>
<%@page import="informe.Conectar"%> <%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ page import="java.io.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="net.sf.jasperreports.engine.*" %> 
<!DOCTYPE html> 
<%
    // captura del nombre del informe    
    String nombre = request.getParameter("nombre");
    //archivos base     
    File reportFile;
    Map parameters = new HashMap();
    String modulo = "";
    int bd = 0;
    /**
     * * ****** listado de informes
     * ********************************************
     */
    if (nombre.equalsIgnoreCase("report1")||nombre.equalsIgnoreCase("report2")||nombre.equalsIgnoreCase("report3")||nombre.equalsIgnoreCase("report4")) 
    {
        modulo = "semana1";
        bd = 1;
    }
    else if(nombre.equalsIgnoreCase("report5"))
    {
        modulo = "semana1";
        bd = 2;
    }
    try
    {
        reportFile = new File(application.getRealPath("/informe/" +modulo) + "/" + nombre + ".jasper");
        // ruta del reporte, parametros y conexion     
        Connection conexion = Conectar.getConexion(bd);
        byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, conexion);
        // generar pdf     
        response.setContentType("application/pdf");
        response.setHeader("Content-disposition", "inline; filename=" + nombre + ".pdf");
        response.setContentLength(bytes.length);
        ServletOutputStream ouputStream = response.getOutputStream();
        ouputStream.write(bytes, 0, bytes.length);
        // limpiar y cerrar flujos de salida     
        ouputStream.flush();
        ouputStream.close();
        // cerrar conexion    
        Conectar.cerrarConexion(conexion);
    }
    catch(Exception e)
    {
        out.write("<h1>"+e.getMessage()+"</h1>");
    }
%> 


