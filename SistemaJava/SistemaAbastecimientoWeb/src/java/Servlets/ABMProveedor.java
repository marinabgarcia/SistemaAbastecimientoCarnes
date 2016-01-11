/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.security.MessageDigest;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Marina
 */
public class ABMProveedor extends HttpServlet {

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
            out.println("<title>Servlet ABMPersona</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ABMPersona at " + request.getContextPath() + "</h1>");
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
        String accion = request.getParameter("accion");
        long cuitProveedor = Long.parseLong(request.getParameter("cuitProveedor"));
        Negocio.Controlador con = new Negocio.Controlador();
        if (!"eliminar".equals(accion) && !"activar".equals(accion)) {
            try {
                String emailProveedor = request.getParameter("emailProveedor");
                String nombreProveedor = new String(request.getParameter("nombreProveedor").getBytes("ISO-8859-1"), "UTF-8");
                String apellidoProveedor = new String(request.getParameter("apellidoProveedor").getBytes("ISO-8859-1"), "UTF-8");
                String direccionProveedor = new String(request.getParameter("direccionProveedor").getBytes("ISO-8859-1"), "UTF-8");
                String telefonoProveedor = request.getParameter("telefonoProveedor");
                String celularProveedor = request.getParameter("celularProveedor");              
                int ciudadProveedor = Integer.parseInt(request.getParameter("ciudad"));
                int provinciaProveedor = Integer.parseInt(request.getParameter("provincia"));
                Entidades.Proveedor proveedor = new Entidades.Proveedor();
                proveedor.setApellidoProveedor(apellidoProveedor);
                proveedor.setCelularProveedor(celularProveedor);
                proveedor.setEmailProveedor(emailProveedor);
                proveedor.setDireccionProveedor(direccionProveedor);
                proveedor.setCuitProveedor(cuitProveedor);
                proveedor.setNombreProveedor(nombreProveedor);
                proveedor.setTelefonoProveedor(telefonoProveedor);
                proveedor.setLocalidadProveedor(ciudadProveedor);
                proveedor.setProvinciaProveedor(provinciaProveedor);
       
                if ("alta".equals(accion)) {
                    proveedor.setEstadoProveedor("Activo");
                    con.altaProveedor(proveedor);
                    request.setAttribute("div", "");
                    request.setAttribute("mensaje", "El Proveedor " + proveedor.getNombreProveedor() + " " + proveedor.getApellidoProveedor() + " se registro correctamente.");
                    request.getRequestDispatcher("proveedores.jsp").forward(request, response);

                } else {
                    con.modificarProveedor(proveedor);
                    request.setAttribute("div", "");
                    request.setAttribute("mensaje", "El Proveedor " + proveedor.getNombreProveedor() + " " + proveedor.getApellidoProveedor() + " se ha modificado correctamente.");
                    request.getRequestDispatcher("proveedores.jsp").forward(request, response);
                }
            } catch (Exception ex) {
                request.setAttribute("div", "");
                request.setAttribute("error", ex.getMessage());
                request.getRequestDispatcher("proveedores.jsp").forward(request, response);
            }
        } else {
            try {
                if ("eliminar".equals(accion)) {
                    con.eliminarProveedor(cuitProveedor);
                } else {
                    con.activarProveedor(cuitProveedor);
                }
                response.getWriter().write("");
            } catch (Exception ex) {
                response.getWriter().write(ex.getMessage());
            }
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
