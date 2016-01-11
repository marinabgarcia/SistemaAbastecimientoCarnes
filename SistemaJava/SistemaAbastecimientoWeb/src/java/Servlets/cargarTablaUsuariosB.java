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
import net.sf.json.JSONObject;

/**
 *
 * @author Marina
 */
public class cargarTablaUsuariosB extends HttpServlet {

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
            out.println("<title>Servlet cargarTablaUsuariosB</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet cargarTablaUsuariosB at " + request.getContextPath() + "</h1>");
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
            String sortapellidoUsuario = request.getParameter("sort[apellidoUsuario]");
            String sortnombreUsuario = request.getParameter("sort[nombreUsuario]");
            String sortdniUsuario= request.getParameter("sort[dniUsuario]");
            String sortdLocalidad = request.getParameter("sort[dLocalidad]");
            String sortname = null, sortorder = null;
            if (sortapellidoUsuario != null) {
                sortname = "apellidoUsuario";
                sortorder = sortapellidoUsuario;
            }
            if (sortnombreUsuario != null) {
                sortname = "nombreUsuario";
                sortorder = sortnombreUsuario;
            }
            if (sortdniUsuario != null) {
                sortname = "dniUsuario";
                sortorder = sortdniUsuario;
            }
            if (sortdLocalidad != null) {
                sortname = "localidad";
                sortorder = sortdLocalidad;
            }
            String searchPhrase = request.getParameter("searchPhrase");
            ArrayList<Entidades.Usuario> usuarios = null;
            usuarios = con.getUsuariosB(sortname, sortorder, searchPhrase);

            //personas = con.getPersonas(page, rp, sortname, sortorder, query);
            //JSONArray jArray = new JSONArray();
            ArrayList<Entidades.Usuario> seleccion = new ArrayList<Entidades.Usuario>();
            if (usuarios != null) {
                for (int i = (current - 1) * rowCount; i < ((current * rowCount > usuarios.size()) ? usuarios.size() : current * rowCount); i++) {
                    Entidades.Usuario usuario = usuarios.get(i);
                    seleccion.add(usuario);
                    //JSONObject jsonObj = new JSONObject();
                    //jsonObj.element("rows", articulo);
                    //jArray.add(jsonObj);
                }
            }
            JSONObject jObj = new JSONObject();
            jObj.element("current", current);
            jObj.element("rowCount", rowCount);
            jObj.element("rows", seleccion);
            if (usuarios == null) {
                jObj.element("total", 0);
            } else {
                jObj.element("total", usuarios.size());
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
