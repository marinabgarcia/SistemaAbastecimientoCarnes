/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Marina
 */
public class ABMArticulo extends HttpServlet {

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
            out.println("<title>Servlet ABMArticulo</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ABMArticulo at " + request.getContextPath() + "</h1>");
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
        int idArticulo = Integer.parseInt(request.getParameter("idArticulo"));
        Negocio.Controlador con = new Negocio.Controlador();
        if (!"eliminar".equals(accion) && !"activar".equals(accion)) {
            try {
                String descripcionArticulo = new String(request.getParameter("descripcionArticulo").getBytes("ISO-8859-1"), "UTF-8");
                int idCalidad= Integer.parseInt(request.getParameter("calidad"));
                double pesoEstimadoArticulo = Double.parseDouble(request.getParameter("pesoEstimadoArticulo"));

                //String foto = new String(request.getParameter("foto").getBytes("ISO-8859-1"), "UTF-8");
                Entidades.Articulo articulo = new Entidades.Articulo();
                articulo.setIdArticulo(idArticulo);
                articulo.setIdCalidad(idCalidad);
                articulo.setDescripcionArticulo(descripcionArticulo);
                articulo.setPesoEstimadoArticulo(pesoEstimadoArticulo);              
                if ("alta".equals(accion)) {
                    articulo.setEstadoArticulo("Activo");
                    con.altaArticulo(articulo);
                    request.setAttribute("div", "");
                    request.setAttribute("mensaje", "El articulo " + articulo.getDescripcionArticulo() + " se registro correctamente.");
                    request.getRequestDispatcher("articulos.jsp").forward(request, response);

                } else {
                    con.modificarArticulo(articulo);
                    request.setAttribute("div", "");
                    request.setAttribute("mensaje", "El articulo " + articulo.getDescripcionArticulo() + " se ha modificado correctamente.");
                    request.getRequestDispatcher("articulos.jsp").forward(request, response);
                }
            } catch (Exception ex) {
                request.setAttribute("div", "");
                request.setAttribute("error", ex.getMessage());
                request.getRequestDispatcher("articulos.jsp").forward(request, response);
            }
        } else {
            try {
                if ("eliminar".equals(accion)) {
                    con.eliminarArticulo(idArticulo);
                } else {
                    con.activarArticulo(idArticulo);
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
