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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;

/**
 *
 * @author Marina
 */
@WebServlet(name = "cargarTablaClientesB", urlPatterns = {"/cargarTablaClientesB"})
public class cargarTablaClientesB extends HttpServlet {

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
            out.println("<title>Servlet cargarTablaClientesB</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet cargarTablaClientesB at " + request.getContextPath() + "</h1>");
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
            Negocio.Controlador con = new Negocio.Controlador();
            int current = Integer.parseInt(request.getParameter("current"));
            int rowCount = Integer.parseInt(request.getParameter("rowCount"));
            String sortapellidoCliente = request.getParameter("sort[apellidoCliente]");
            String sortnombreCliente = request.getParameter("sort[nombreCliente]");
            String sortrazonSocialCliente= request.getParameter("sort[razonSocialCliente]");
            String sortdniCliente = request.getParameter("sort[dniCliente]");
            String sortname = null, sortorder = null;
            if (sortapellidoCliente != null) {
                sortname = "apellidoCliente";
                sortorder = sortapellidoCliente;
            }
            if (sortnombreCliente != null) {
                sortname = "nombreCliente";
                sortorder = sortnombreCliente;
            }
            if (sortrazonSocialCliente != null) {
                sortname = "razonSocialCliente";
                sortorder = sortrazonSocialCliente;
            }
            if (sortdniCliente != null) {
                sortname = "dniCliente";
                sortorder = sortdniCliente;
            }
            String searchPhrase = request.getParameter("searchPhrase");
            ArrayList<Entidades.Cliente> clientes = null;
            clientes = con.getClientesB(sortname, sortorder, searchPhrase);

            //personas = con.getPersonas(page, rp, sortname, sortorder, query);
            //JSONArray jArray = new JSONArray();
            ArrayList<Entidades.Cliente> seleccion = new ArrayList<Entidades.Cliente>();
            if (clientes != null) {
                for (int i = (current - 1) * rowCount; i < ((current * rowCount > clientes.size()) ? clientes.size() : current * rowCount); i++) {
                    Entidades.Cliente cliente = clientes.get(i);
                    seleccion.add(cliente);
                    //JSONObject jsonObj = new JSONObject();
                    //jsonObj.element("rows", articulo);
                    //jArray.add(jsonObj);
                }
            }
            JSONObject jObj = new JSONObject();
            jObj.element("current", current);
            jObj.element("rowCount", rowCount);
            jObj.element("rows", seleccion);
            if (clientes == null) {
                jObj.element("total", 0);
            } else {
                jObj.element("total", clientes.size());
            }
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            out.println(jObj);
            out.close();
        } catch (Exception ex) {
            Logger.getLogger(cargarTablaPrecio.class.getName()).log(Level.SEVERE, null, ex);
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
