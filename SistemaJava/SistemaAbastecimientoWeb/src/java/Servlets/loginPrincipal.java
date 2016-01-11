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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Hamal
 */
@WebServlet(name = "loginPrincipal", urlPatterns = {"/loginPrincipal"})
public class loginPrincipal extends HttpServlet {

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
            out.println("<title>Servlet loginPrincipal</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet loginPrincipal at " + request.getContextPath() + "</h1>");
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
        Long dni;
        String contra = "";
       
        Entidades.Usuario usuario;
        try {

            HttpSession session = request.getSession(true);
            usuario = (Entidades.Usuario) session.getAttribute("usuarioConectado");
            if (usuario == null) {
                String hash = "";
                dni = Long.parseLong(request.getParameter("loginDni"));
                contra = request.getParameter("loginContra");
                //encriptar
                MessageDigest md;
                byte[] buffer, digest;
                
                contra = new String(request.getParameter("loginContra").getBytes("ISO-8859-1"), "UTF-8");
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
                Negocio.Controlador con = new Negocio.Controlador();
                usuario = con.identificarUsuario(dni, hash);
                if (usuario != null) {
                    session.setAttribute("usuarioConectado", usuario);
                    
                  //  request.setAttribute("ventana", "ventanaFechaSistema");
                    request.getRequestDispatcher("home.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect("login.jsp");
            }
        } catch (Exception ex) {
            request.setAttribute("error", ex.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);

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
