/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.sql.Time;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author Hamal
 */
public class compra extends HttpServlet {

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
            out.println("<title>Servlet compra</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet compra at " + request.getContextPath() + "</h1>");
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
            
            String datosLineas = request.getParameter("datosLineas");
            final JSONObject obj = new JSONObject(datosLineas);
            final JSONArray datosLineasCompra = obj.getJSONArray("datos");
            final int n = datosLineasCompra.length();
            ArrayList<Entidades.LineaDeCompra> listaArticulo = new ArrayList<Entidades.LineaDeCompra>();
            for (int i = 0; i < n; ++i) {
                final JSONObject lineaCompra = datosLineasCompra.getJSONObject(i);
                Entidades.LineaDeCompra linea = new Entidades.LineaDeCompra();
                linea.setIdArticulo(lineaCompra.getInt("idArticulo"));
                linea.setCantidadLineaCompra(lineaCompra.getInt("cantidadLineaCompra"));
                linea.setPesoLineaCompra(lineaCompra.getDouble("pesoLineaCompra"));
                linea.setObservacionLineaCompra(lineaCompra.getString("observacionLineaCompra"));
                listaArticulo.add(linea);
            }
            long cuitProveedor = Long.parseLong(request.getParameter("cuitProveedor"));
            String nroRemitoCompra = request.getParameter("nroRemitoCompra");
            String nroFacturaCompra = request.getParameter("nroFacturaCompra");
            String coincide = request.getParameter("coincide");

            double totalCompraRemito = 0;
            if ("false".equals(coincide)) {
                totalCompraRemito = Double.parseDouble(request.getParameter("totalCompraRemito"));
            } else {
                totalCompraRemito = Double.parseDouble(request.getParameter("totalCompraCalculado"));
            }
            Date fechaHoy = Date.valueOf(request.getParameter("fechaHoy"));
            Time horaHoy = Time.valueOf(request.getParameter("horaHoy"));
            Negocio.Controlador con = new Negocio.Controlador();
            // trae el dni de la sesion
            HttpSession session = request.getSession(true);
            Entidades.Usuario usuarioConectado=(Entidades.Usuario) session.getAttribute("usuarioConectado");
            long dniUsuario = usuarioConectado.getDniUsuario();
            // trae el array del jsp
            ArrayList<Entidades.LineaDeCompra> listaCompra = new ArrayList<Entidades.LineaDeCompra>();
            listaCompra = con.agregarLineaCompra(dniUsuario, cuitProveedor, nroRemitoCompra, nroFacturaCompra, listaArticulo, fechaHoy, horaHoy, totalCompraRemito);
            response.getWriter().write("");
            
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
