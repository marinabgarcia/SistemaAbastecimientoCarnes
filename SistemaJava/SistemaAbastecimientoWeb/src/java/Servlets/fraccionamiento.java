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
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Hamal
 */
public class fraccionamiento extends HttpServlet {

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
            out.println("<title>Servlet fraccionamiento</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet fraccionamiento at " + request.getContextPath() + "</h1>");
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
            long idLineaCompra = Long.parseLong(request.getParameter("idLineaCompra"));
            int cantidadAFraccionar = Integer.parseInt(request.getParameter("cantidadAFraccionar"));
            int idArticuloAFraccionar = Integer.parseInt(request.getParameter("idArticuloAFraccionar"));
            String datosFraccionamiento = request.getParameter("datosFraccionamiento");
            final JSONObject obj = new JSONObject(datosFraccionamiento);
            final JSONArray datosCortes = obj.getJSONArray("datos");
            final int n = datosCortes.length();
            ArrayList<Entidades.Articulo> listaArticulo = new ArrayList<Entidades.Articulo>();
            for (int i = 0; i < n; ++i) {
                final JSONObject lineaCompra = datosCortes.getJSONObject(i);
                Entidades.Articulo articulo = new Entidades.Articulo();
                articulo.setIdArticulo(lineaCompra.getInt("idArticulo"));
                articulo.setCantidadFraccionada(lineaCompra.getInt("cantidadLineaCompra"));
                listaArticulo.add(articulo);
            }
            Negocio.Controlador con = new Negocio.Controlador();
            con.guardarFraccionamiento(idLineaCompra, listaArticulo, cantidadAFraccionar,idArticuloAFraccionar);
            response.getWriter().write("");
        } catch (ClassNotFoundException ex) {
            response.getWriter().write(ex.getMessage());
        } catch (Exception ex) {
            response.getWriter().write(ex.getMessage());
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
