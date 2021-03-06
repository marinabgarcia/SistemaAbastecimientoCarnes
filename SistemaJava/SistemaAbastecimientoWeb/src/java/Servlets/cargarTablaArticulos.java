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
public class cargarTablaArticulos extends HttpServlet {

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
            out.println("<title>Servlet cargarTablaArticulos</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet cargarTablaArticulos at " + request.getContextPath() + "</h1>");
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
        doPost(request, response);
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
            int page = Integer.parseInt(request.getParameter("page"));
            int rp = Integer.parseInt(request.getParameter("rp"));
            String sortname = request.getParameter("sortname");
            String sortorder = request.getParameter("sortorder");
            String query = request.getParameter("busqueda");
            String filtro = request.getParameter("filtro");
            Negocio.Controlador con = new Negocio.Controlador();
            ArrayList<Entidades.Articulo> articulos;
            articulos = con.getArticulos(page, rp, sortname, sortorder, query, filtro);
            //personas = con.getPersonas(page, rp, sortname, sortorder, query);
            int i = 1;
            JSONArray jArray = new JSONArray();
            if (articulos != null) {
                for (Entidades.Articulo articulo : articulos) {
                    JSONObject jsonObj = new JSONObject();
                    jsonObj.element("id", i);
                    jsonObj.element("cell", articulo);
                    jArray.add(jsonObj);
                    i++;
                }
            }
            JSONObject jObj = new JSONObject();
            jObj.element("page", page);
            if (articulos == null) {
                jObj.element("total", 0);
            } else {
                jObj.element("total", con.getTotalArticulos(query, filtro).size());
            }
            jObj.element("rows", jArray);
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            out.println(jObj);
            out.close();
        } catch (Exception ex) {
            Logger.getLogger(cargarTablaArticulos.class.getName()).log(Level.SEVERE, null, ex);
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
