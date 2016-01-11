/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Hamal
 */
public class ABMUsuario extends HttpServlet {

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
            out.println("<title>Servlet ABMUsuario</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ABMUsuario at " + request.getContextPath() + "</h1>");
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
        long dniUsuario = Long.parseLong(request.getParameter("dniUsuario"));
        Negocio.Controlador con = new Negocio.Controlador();
        if (!"eliminar".equals(accion) && !"activar".equals(accion)) {
            try {

                String emailUsuario = new String(request.getParameter("emailUsuario").getBytes("ISO-8859-1"), "UTF-8");
                String tipoUsuario = new String(request.getParameter("tipoUsuario").getBytes("ISO-8859-1"), "UTF-8");
                 //encriptar
                MessageDigest md;
                byte[] buffer, digest;
                String hash = "";
                String contra = new String(request.getParameter("pass").getBytes("ISO-8859-1"), "UTF-8");
                 if (contra != "") {
                    buffer = contra.getBytes();
                    md = MessageDigest.getInstance("SHA1");
                    md.update(buffer);
                    digest = md.digest();

                    for (byte aux : digest) {
                        int b = aux & 0xff;
                        if (Integer.toHexString(b).length() == 1) {
                            hash += "0";
                        }
                        hash += Integer.toHexString(b);
                    }
                } else {
                    hash = "";
                }
                //String fotoUsuario = new String(request.getParameter("fotoUsuario").getBytes("ISO-8859-1"), "UTF-8");
                String nombreUsuario = new String(request.getParameter("nombreUsuario").getBytes("ISO-8859-1"), "UTF-8");
                String apellidoUsuario = new String(request.getParameter("apellidoUsuario").getBytes("ISO-8859-1"), "UTF-8");
                String direccionUsuario = new String(request.getParameter("direccionUsuario").getBytes("ISO-8859-1"), "UTF-8");
                String telefonoUsuario = request.getParameter("telefonoUsuario");
                String celularUsuario = request.getParameter("celularUsuario");
                int ciudadUsuario = Integer.parseInt(request.getParameter("ciudad"));

                int provinciaUsuario = Integer.parseInt(request.getParameter("provincia"));

                Entidades.Usuario usuario = new Entidades.Usuario();
                usuario.setApellidoUsuario(apellidoUsuario);
                usuario.setTipoUsuario(tipoUsuario);
                usuario.setCelularUsuario(celularUsuario);
                usuario.setEmailUsuario(emailUsuario);
                usuario.setDireccionUsuario(direccionUsuario);
                usuario.setDniUsuario(dniUsuario);
                usuario.setContraseña(hash);
                //usuario.setFotoUsuario(fotoUsuario);
                usuario.setNombreUsuario(nombreUsuario);
                usuario.setTelefonoUsuario(telefonoUsuario);
                usuario.setLocalidadUsuario(ciudadUsuario);
                usuario.setProvinciaUsuario(provinciaUsuario);

                if ("alta".equals(accion)) {
                    Date fechaAlta = Date.valueOf(request.getParameter("fechaAlta"));
                    usuario.setEstado("Activo");
                    usuario.setFechaAlta(fechaAlta);
                    con.altaUsuario(usuario);
                    request.setAttribute("div", "");
                    request.setAttribute("mensaje", "El usuario " + usuario.getNombreUsuario() + " " + usuario.getApellidoUsuario() + " se registro correctamente.");
                    request.getRequestDispatcher("usuarios.jsp").forward(request, response);

                } else {
                    con.modificarUsuario(usuario);
                    request.setAttribute("div", "");
                    request.setAttribute("mensaje", "El usuario " + usuario.getNombreUsuario() + " " + usuario.getApellidoUsuario() + " se ha modificado correctamente.");
                    request.getRequestDispatcher("usuarios.jsp").forward(request, response);
                }
            } catch (Exception ex) {
                request.setAttribute("div", "");
                request.setAttribute("error", ex.getMessage());
                request.getRequestDispatcher("usuarios.jsp").forward(request, response);
            }
        } else {
            try {
                if ("eliminar".equals(accion)) {
                    Date fechaBaja =Date.valueOf(request.getParameter("fechaBaja"));
                    con.eliminarUsuario(dniUsuario, fechaBaja);

                } else {
                    con.activarUsuario(dniUsuario);
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
