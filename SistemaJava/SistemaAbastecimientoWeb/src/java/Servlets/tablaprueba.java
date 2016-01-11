/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 *
 * @author Marina
 */
public class tablaprueba extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet tablaprueba</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet tablaprueba at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            System.out.println(" --> doPost ");
            int current = Integer.parseInt(request.getParameter("current"));
            int rowCount = Integer.parseInt(request.getParameter("rowCount"));
            String sort = request.getParameter("sort[descripcion]");
            String sortid = request.getParameter("sort[dniCliente]");
            //String sortorder = request.getParameter("sortorder");
            String searchPhrase = request.getParameter("searchPhrase");
            /*String filtro = request.getParameter("filtro");
            Negocio.Controlador con = new Negocio.Controlador();
            ArrayList<Entidades.Cliente> clientes;
            clientes= con.getClientes(page, rp, sortname, sortorder, query,filtro);
            //personas = con.getPersonas(page, rp, sortname, sortorder, query);
            int i = 1;*/
            JSONObject jObj1 = new JSONObject();
            jObj1.element("current", 1);
            jObj1.element("rowCount", 10);
            JSONArray jArray = new JSONArray();                                 
            JSONObject jsonObj = new JSONObject();
            jsonObj.element("dniCliente", 3493796);
            jArray.add(jsonObj);
            jObj1.element("rows", jArray);
            jObj1.element("total", 11);
            
           
           
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            out.println(jObj1);
            out.close();
        } catch (Exception ex) {
            Logger.getLogger(cargarTablaClientes.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
