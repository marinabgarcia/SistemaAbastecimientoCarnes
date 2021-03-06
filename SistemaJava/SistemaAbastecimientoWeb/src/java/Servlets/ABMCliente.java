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
public class ABMCliente extends HttpServlet {

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
        long dniCliente = Long.parseLong(request.getParameter("dniCliente"));
        Negocio.Controlador con = new Negocio.Controlador();
        if (!"eliminar".equals(accion) && !"activar".equals(accion)) {
            try {
                long cuitCliente = Long.parseLong(request.getParameter("cuitCliente"));
                String emailCliente = request.getParameter("emailCliente");
                String razonSocialCliente = new String(request.getParameter("razonSocialCliente").getBytes("ISO-8859-1"), "UTF-8");
                String nombreCliente = new String(request.getParameter("nombreCliente").getBytes("ISO-8859-1"), "UTF-8");
                String apellidoCliente = new String(request.getParameter("apellidoCliente").getBytes("ISO-8859-1"), "UTF-8");
                String direccionCliente = new String(request.getParameter("direccionCliente").getBytes("ISO-8859-1"), "UTF-8");
                String telefonoCliente = request.getParameter("telefonoCliente");
                String celularCliente = request.getParameter("celularCliente");              
                int ciudadCliente = Integer.parseInt(request.getParameter("ciudad"));
                int tipoCliente = Integer.parseInt(request.getParameter("tipoCliente"));
                int provinciaCliente = Integer.parseInt(request.getParameter("provincia"));

                //String foto = new String(request.getParameter("foto").getBytes("ISO-8859-1"), "UTF-8");
                Entidades.Cliente cliente = new Entidades.Cliente();
                cliente.setApellidoCliente(apellidoCliente);
                cliente.setCelularCliente(celularCliente);
                cliente.setEmailCliente(emailCliente);
                cliente.setDireccionCliente(direccionCliente);
                cliente.setDniCliente(dniCliente);
                cliente.setCuitCliente(cuitCliente);
                cliente.setRazonSocialCliente(razonSocialCliente);
                cliente.setIdTipoCliente(tipoCliente);
                cliente.setNombreCliente(nombreCliente);
                cliente.setTelefonoCliente(telefonoCliente);
                cliente.setLocalidadCliente(ciudadCliente);
                cliente.setProvinciaCliente(provinciaCliente);
       
                if ("alta".equals(accion)) {
                    cliente.setEstadoCliente("Activo");
                    con.altaCliente(cliente);
                    request.setAttribute("div", "");
                    request.setAttribute("mensaje", "El cliente " + cliente.getNombreCliente() + " " + cliente.getApellidoCliente() + " se registro correctamente.");
                    request.getRequestDispatcher("clientes.jsp").forward(request, response);

                } else {
                    con.modificarCliente(cliente);
                    request.setAttribute("div", "");
                    request.setAttribute("mensaje", "El cliente " + cliente.getNombreCliente() + " " + cliente.getApellidoCliente() + " se ha modificado correctamente.");
                    request.getRequestDispatcher("clientes.jsp").forward(request, response);
                }
            } catch (Exception ex) {
                request.setAttribute("div", "");
                request.setAttribute("error", ex.getMessage());
                request.getRequestDispatcher("clientes.jsp").forward(request, response);
            }
        } else {
            try {
                if ("eliminar".equals(accion)) {
                    con.eliminarCliente(dniCliente);
                } else {
                    con.activarCliente(dniCliente);
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
